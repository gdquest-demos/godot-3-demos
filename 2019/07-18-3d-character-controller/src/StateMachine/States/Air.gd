tool
extends State


signal jumped

onready var jump_delay: Timer = $JumpDelay


func _get_configuration_warning() -> String:
	return "" if $JumpDelay else "%s requires a Timer child named JumpDelay" % name


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	if event.is_action_pressed("jump"):
		if move.velocity.y <= 0.0 and jump_delay.time_left > 0.0:
			move.velocity = move.calculate_velocity(
					move.velocity, Vector3(0.0, move.JUMP_SPEED, 0.0), 1.0, Vector3.UP)
		emit_signal("jumped")
	else:
		move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.velocity = msg.velocity if "velocity" in msg else move.velocity
	jump_delay.start()


func exit() -> void:
	var move: = get_parent()
