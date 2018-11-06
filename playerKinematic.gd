extends KinematicBody2D

# Member variables
export var GRAVITY = 500.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
export var WALK_FORCE = 600
export var WALK_MIN_SPEED = 10
export var WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
export var JUMP_SPEED = 600
export var JUMP_MAX_AIRBORNE_TIME = 0.2
#var max_jump_velocity = -720
#var min_jump_velocity = -150


export var SLIDE_STOP_VELOCITY = 9.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
#Time the player can jump after leaving an edge
export var on_air_time = 3 
var jumping = false

var prev_jump_pressed = false
export var isGreen = true

#Colorswitch Mechanic
func SwitchColor():
	isGreen = not isGreen
	if isGreen:
		$AnimationPlayer.play("SwitchPurpleToOrange")
	else:
		$AnimationPlayer.play("SwitchOrangeToPurple")
		
func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	
	var stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
			
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false
			
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		#Player can jump, even after leaving the Edge for some time
		velocity.y = -JUMP_SPEED
		jumping = true
		
	#if event.is_action_released("jump") && velocity.y < -500:
	#	velocity.y = -500
	
	on_air_time += delta
	prev_jump_pressed = jump
	
	if Input.is_action_just_pressed("switchColor"):
			SwitchColor()