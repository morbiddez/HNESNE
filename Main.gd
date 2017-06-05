extends Node2D

func _ready():
	set_fixed_process(true)
func _fixed_process(delta):
	if(Input.is_action_pressed("QUIT_GAME")):
		get_tree().quit()
