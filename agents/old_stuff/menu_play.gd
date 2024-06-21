extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init():
	print("Hello from Play Menu landing")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://starting_folder/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_P):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://starting_folder/main_menu.tscn")

func _on_play_game_pressed():
	get_tree().change_scene_to_file("res://common/play_game_parameters.tscn")

func _on_run_agent_pressed():
	pass # Replace with function body.

func _on_options_pressed():
	get_tree().change_scene_to_file("res://starting_folder/options_operating.tscn")

func _on_return_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://starting_folder/main_menu.tscn") 
