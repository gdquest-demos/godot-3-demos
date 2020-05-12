extends KinematicBody2D

export var MoveSpeed = 500

func _process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed('move_left'):
		motion.x = -1
	elif Input.is_action_pressed('move_right'):
		motion.x = 1
	if Input.is_action_pressed('move_up'):
		motion.y = -1
	elif Input.is_action_pressed('move_down'):
		motion.y = 1
	
	move_and_collide(motion.normalized() * MoveSpeed * delta)
