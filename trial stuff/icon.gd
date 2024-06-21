extends Sprite3D

var coins = 5
var player_name = "robot"
var hearts = 3.5
const MY_SPEED = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello world")
	minion()
	print (add_these_numbers(5,6))

func minion():
	print("banana")
	
	# and ehre is a comment to check on Git 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input() 

func add_these_numbers(x, y):
	return x + y
	
func check_input():
	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(-MY_SPEED))
	elif Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(MY_SPEED))
