extends State


func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor():
		if not move.get_move_direction().x and not move.get_move_direction().z:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")
	move.physics_process(delta)
