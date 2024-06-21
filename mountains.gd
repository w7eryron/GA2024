extends Node3D

# Terrain size
var width = 100
var depth = 100
var max_height = 20

# Mountain parameters
var mountain_frequency = 0.05
var mountain_amplitude = 10

func _ready():
	var mesh_instance = $MeshInstance3D
	var mesh = mesh_instance.mesh_instance.mesh

	if mesh:
		var collision_shape = generate_collision_shape(mesh)
		var static_body = $StaticBody3D
		static_body.collision_shape = collision_shape
	else:
		print("Mesh not found in MeshInstance3D.")

func generate_collision_shape(mesh: Mesh):
	var collision_shape = ConcavePolygonShape3D.new()

	for i in range(mesh.get_surface_count()):
		var surface_arrays = mesh.surface_get_arrays(i)
		var vertices = surface_arrays[Mesh.ARRAY_VERTEX]

		var points = PackedVector3Array()
		points.resize(vertices.size())
		for j in range(vertices.size()):
			points[j] = vertices[j]

		collision_shape.set_faces(points)

	return collision_shape


func generate_terrain_mesh():
	var arrays = []
	var vertices = PackedVector3Array()
	var normals = PackedVector3Array()
	var uvs = PackedVector2Array()
	var indices = PackedInt32Array()

	var height_map = generate_height_map()

	for x in range(width):
		for z in range(depth):
			var height = height_map[x][z]
			var vertex = Vector3(x, height, z)
			vertices.append(vertex)

			# Calculate normals (for simplicity, using up vector)
			var normal = Vector3.UP
			normals.append(normal)

			# UV coordinates
			var uv = Vector2(x / float(width), z / float(depth))
			uvs.append(uv)

	for x in range(width - 1):
		for z in range(depth - 1):
			var i0 = x + z * width
			var i1 = x + (z + 1) * width
			var i2 = (x + 1) + z * width
			var i3 = (x + 1) + (z + 1) * width

			indices.append_array([i0, i1, i2, i2, i1, i3])

	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh



func generate_height_map():
	var height_map = []
	for x in range(width):
		var row = []
		for z in range(depth):
			var height = noise_height(x, z)
			row.append(height)
			height_map.append(row)
	return height_map

func noise_height(x, z):
	return noise(Vector2(x * mountain_frequency, z * mountain_frequency)) * mountain_amplitude

func noise(p: Vector2) -> float:
	return sin(p.x + p.y)
