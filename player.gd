extends KinematicBody2D

export var MOTION_SPEED = 160
const RUN_SPEED = 1
var rayNode 

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	rayNode = get_node("RayCast2D")
func _fixed_process(delta):
	var motion = Vector2()
	var run = 1
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0,-1)
		rayNode.set_rotd(180)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1,0)
		rayNode.set_rotd(90)
	if (Input.is_action_pressed("move_down")):
		motion += Vector2(0,1)
		rayNode.set_rotd(0)
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1,0)
		rayNode.set_rotd(-90)
	if (Input.is_key_pressed(KEY_SPACE)):
		run = 2
	else:
		run = RUN_SPEED
	motion = motion.normalized()*MOTION_SPEED*delta*run
	move(motion)
	
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1