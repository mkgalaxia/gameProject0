extends KinematicBody2D

var motion = Vector2()
var speed = 10
var canMove = true
var move_direction = Vector2(0,0)

func _fixed_process(delta):
	
	if (canMove):
		move_player()

func move_player():
	
	move_direction = Vector2(0,0)
	if Input.is_key_pressed(KEY_A):
		move_direction += Vector2(-1,0)
	if Input.is_key_pressed(KEY_D):
		move_direction += Vector2(1,0)
	move(move_direction.normalized() * speed)
	
	pass
