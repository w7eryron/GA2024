extends Node3D



func _init():
	print("Hello from my Agent landing")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://starting_folder/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_P):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://starting_folder/main_menu.tscn")
	
