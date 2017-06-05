extends Node2D

#Simple Code in root node to exit game when escape key is pressed
func _ready():
	set_fixed_process(true)
func _fixed_process(delta):
	if(Input.is_action_pressed("QUIT_GAME")):
		get_tree().quit()
