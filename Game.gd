extends Spatial


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.reset_score()

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
