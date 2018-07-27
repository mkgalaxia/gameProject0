extends KinematicBody2D

var run_speed = 450
var jump_speed = -800
var gravity = 1800
var cooldown_time = 0
var velocity = Vector2(0,0)
var jumping = false
var canMove = true
var on_cooldown = false
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
		player_actions(delta)
		cooldown(delta)
		cooldown_time -= delta
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if jumping and is_on_floor():
			jumping = false
			air_jumps_left = total_air_jumps

func move_player(delta):
	velocity.x = 0
	var left = Input.is_action_pressed('ui_left')
	var right = Input.is_action_pressed('ui_right')
	var crouch = Input.is_action_pressed('ui_down')
	#remember to make crouch and drop mechanic
	var jump = Input.is_action_just_pressed('ui_space')
	
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

func player_actions(delta):
	var water = Input.is_action_just_pressed('ui_j') or Input.is_action_just_pressed('ui_water_left') or Input.is_action_just_pressed('ui_water_right') or Input.is_action_just_pressed('ui_water_up') or Input.is_action_just_pressed('ui_water_down')
	var fireball = Input.is_action_just_pressed('ui_fire')
	var ice = Input.is_action_just_pressed('ui_ice')
	var earth = Input.is_action_just_pressed('ui_earth')
	var rewind = Input.is_action_just_pressed('ui_rewind')
	var freeze_time = Input.is_action_just_pressed('ui_freeze')
	var recover_platform = Input.is_action_just_pressed('ui_special')
	
	if water and !on_cooldown:
		water_attack(delta)
	if fireball and !on_cooldown:
		fire_attack(delta)
		cooldown(delta)
	if ice and !on_cooldown:
		ice_attack(delta)
	if earth and !on_cooldown:
		earth_attack(delta)
	if rewind and !on_cooldown:
		rewind_time(delta)
	if freeze_time and !on_cooldown:
		freeze_time(delta)
	if recover_platform and !on_cooldown:
		recover_platform(delta)

func cooldown(delta):
	if cooldown_time <= 0:
		cooldown_time = 0
		on_cooldown = false

func water_attack(delta):
	on_cooldown = true
	cooldown_time = .5
	print('sploosh sploosh')

func fire_attack(delta):
	on_cooldown = true
	cooldown_time = .5
	print('Explosion')

func ice_attack(delta):
	on_cooldown = true
	cooldown_time = .5
	print('Freeze')

func earth_attack(delta):
	on_cooldown = true
	cooldown_time = .5
	print('Stoned')

func rewind_time(delta):
	print('WOOWOOWOOWOOWOOWOO')

func freeze_time(delta):
	print('free...eze')

func recover_platform(delta):
	print('RezPlz')
