extends RigidBody3D

var bombTime = 20

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

var landing_site = Global.landing_site
var launch_site = Global.launch_site
var rocket_position = Global.rocket_position
var rocket_speed = Global.rocket_velocity

@onready var twist_pivot := $TwistPvot
@onready var pitch_pivot = $TwistPvot/PitchPivot

@onready var fire = $Fire
@onready var kaboom_1 = $Kaboom1
@onready var smoke = $Smoke



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(3.0).timeout
	# below is jsut a sample autonomous mode launch
	explode()
	apply_central_force(Vector3.UP * 80.0  * bombTime)
	await get_tree().create_timer(4.95).timeout
	explode()
	apply_central_force(Vector3.UP * 60.0  * bombTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	check_input()
	#check_kablooey()
	# handling bomb drops keys
	if Input.is_key_pressed(KEY_Y):
		explode()
		apply_central_force(Vector3.UP * 200.0 * delta * bombTime)
	if Input.is_key_pressed(KEY_U):
		explode()
		apply_central_force(Vector3.UP * 300.0 * delta * bombTime)
	if Input.is_key_pressed(KEY_I):
		explode()
		apply_central_force(Vector3.UP * 800.0 * delta * bombTime)
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	# handling parameter labels
	var my_velocity = linear_velocity
	$my_speed.text = str(round(my_velocity))
	rocket_position = position
	var my_distL = (rocket_position - Global.landing_site).length()
	$my_height.text = str(round(rocket_position))
	$my_distL.text = str(round(my_distL))
	$my_roll.text = str(round(Global.heading))
	$land_location.text = str(round(Global.landing_site))
	$my_bombs.text = str(round(Global.bombs))
	
	if(rocket_position.distance_to(Global.landing_site)<=1.0):
		get_tree().change_scene_to_file("res://common/safe_landing.tscn")
	
	#if(rocket_position.y < 0):
		#kablooey()
		
	# handling pitch and roll
	var input = Vector3.ZERO
	input.x = Input.get_axis("roll_left", "roll_right")
	input.z = Input.get_axis("pitch_down", "pitch_up")
	apply_central_force(twist_pivot.basis* input*1200.0 * delta)
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x, -0.5, 0.9 )
	twist_input = 0.0
	pitch_input = 0.0

func	explode():
	fire.emitting = true
	kaboom_1.play(true)
	smoke.emitting = true
	#Global.bombs -=  1
	if (Global.bombs <= 0):
		kablooey()
	return true
	
func kablooey():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://common/crashed.tscn")
	
# handling movemenet of mouse camera 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity 

func check_input():
	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(-.3))
		Global.heading = get_rotation_degrees().y
	elif Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(.3))
		Global.heading = get_rotation_degrees().y

func check_kablooey():
	if (position.y < 10 && explode()):
		kablooey()
