extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_line_edit_text_submitted(new_text):
	$Label.text = new_text
	var my_int = int(new_text)
	my_int = 10+my_int
	print(my_int)
