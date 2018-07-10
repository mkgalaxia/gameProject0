extends KinematicBody2D

var motion = Vector2()

func _physics_process(delta):
	
	if Input.is_action_pressed("KEY_D"):
		motion.x = 320
	
	move_and_slide(motion)
	pass
