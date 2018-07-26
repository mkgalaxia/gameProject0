extends KinematicBody2D

var run_speed = 450
var jump_speed = -800
var gravity = 1800
var velocity = Vector2(0,0)
var jumping = false
var canMove = true
var total_air_jumps = 0
var air_jumps_left

func _ready():
	#remember to change to jump item later
	if canMove:
		total_air_jumps += 1
	air_jumps_left = total_air_jumps

func _physics_process(delta):
	if(canMove):
		move_player(delta)
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if jumping and is_on_floor():
			jumping = false
			air_jumps_left = total_air_jumps

func move_player(delta):
	velocity.x = 0
	var left = Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)
	var right = Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)
	var jump = Input.is_action_just_pressed('ui_select')
	
	if jump and air_jumps_left > 0 and !is_on_floor():
		jumping = true
		velocity.y = jump_speed
		air_jumps_left -= 1
	elif jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if left:
		velocity.x -= run_speed
	if right:
		velocity.x += run_speed