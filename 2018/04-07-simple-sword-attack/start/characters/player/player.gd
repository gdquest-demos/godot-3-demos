extends "res://characters/character.gd"


func _input(event):
	if event.is_action_pressed("attack") and state != ATTACK:
		_change_state(ATTACK)


func _physics_process(delta):
	input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	if input_direction and input_direction != last_move_direction:
		emit_signal('direction_changed', input_direction)
