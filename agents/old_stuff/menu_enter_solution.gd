extends Node2D

@onready var drop_down_new_solution = $OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	add_items()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_items():
	drop_down_new_solution.add_item("Modify This Solution")
	drop_down_new_solution.add_item("Erase and Begin New Solution")
	drop_down_new_solution.add_item("Add New Step After Step Number")
	drop_down_new_solution.add_item("Modify Step Number")
	drop_down_new_solution.add_item("Erase Step Number")
	drop_down_new_solution.add_item("Add Bomb")
	drop_down_new_solution.add_item("Add New Pitch")
	drop_down_new_solution.add_item("Add New Heading")
	drop_down_new_solution.add_item("Add Wait Time")


func _on_option_button_item_selected(index):
	var current_selected = index
	
	if current_selected == 0:
		print("Choose and Option")
	
	if current_selected == 1:
		print("Erase and Begin New Solution")
		
	if current_selected == 2:
		print("Add new Step after step number")
	
	if current_selected == 3:
		print("Modify Step number")
		
	if current_selected == 4:
		print("Erase Step number")
	
	if current_selected == 5:
		print("Add Bomb")
	
	if current_selected == 6:
		print("Add New Pitch")
	
	if current_selected == 7:
		print("Add New Heading")
		
	if current_selected == 8:
		print("Add Wait Time")
	


func _on_cancel_and_return_pressed():
	print("cancel and return")

func _on_save_and_return_pressed():
	print("save and returne")

func _on_begin_solution_pressed():
	print("Flying")

func _on_help_notes_pressed():
	print("Help Notes")
	
