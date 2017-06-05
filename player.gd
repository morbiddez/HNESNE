extends KinematicBody2D

export var MOTION_SPEED = 160 #Make Variable Editable form GUI
const RUN_SPEED = 1 #Base Run Speed
var rayNode #import 2D Ray child

func _ready():  #Runs when assets finish loading
	set_fixed_process(true) #initalize delta
	set_process_input(true) #initalize Input processing
	rayNode = get_node("RayCast2D") #import 2D Ray child
func _fixed_process(delta): #runs on ever frame
	var motion = Vector2() #initial Motion Container
	var run = 1 #initial Run container
	
	if (Input.is_action_pressed("move_up")): #Move Up
		motion += Vector2(0,-1)
		rayNode.set_rotd(180)
	if (Input.is_action_pressed("move_right")): #move right
		motion += Vector2(1,0)
		rayNode.set_rotd(90)
	if (Input.is_action_pressed("move_down")): #move down
		motion += Vector2(0,1)
		rayNode.set_rotd(0)
	if (Input.is_action_pressed("move_left")): #move left
		motion += Vector2(-1,0)
		rayNode.set_rotd(-90)
	if (Input.is_key_pressed(KEY_SPACE)): #Run
		run = 2
	else:
		run = RUN_SPEED #reset to default run speed while key isn't pressed
	motion = motion.normalized()*MOTION_SPEED*delta*run #Cacl speed and normalize accross diag
	move(motion) #move character
	
	#adjust movemen to Slide accross collision poly's for easier navigation and reduced stickyness
	
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1