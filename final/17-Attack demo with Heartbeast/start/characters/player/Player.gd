extends "res://characters/Character.gd"


func _input(event):
	if event.is_action_pressed("attack"):
		if current_state in [ATTACK, STAGGER, DIE, DEAD]:
			return
		_change_state(ATTACK)


func _physics_process(delta):
	input_direction = Vector2()

	if Input.is_action_pressed("move_left"):
		input_direction.x = -1
	elif Input.is_action_pressed("move_right"):
		input_direction.x = 1
	elif Input.is_action_pressed("move_up"):
		input_direction.y = -1
	elif Input.is_action_pressed("move_down"):
		input_direction.y = 1
