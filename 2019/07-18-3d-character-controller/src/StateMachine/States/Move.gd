extends State


const MAX_SPEED: = Vector3(20.0, 20.0, 20.0)
const JUMP_SPEED: = 12.5

var velocity: = Vector3.ZERO setget set_velocity

var _rotations: = {
	str(Vector3(0, 0, -1)): 0, # forward
	str(Vector3(0, 0, 1)): 180, # back
	str(Vector3(1, 0, 0)): -90, # right
	str(Vector3(-1, 0, 0)): 90, # left
	str(Vector3(1, 0, -1).normalized()): -45, # forward - right
	str(Vector3(1, 0, 1).normalized()): -135, # back - right
	str(Vector3(-1, 0, -1).normalized()): 45, # forward - left
	str(Vector3(-1, 0, 1).normalized()): 135, # back - left
	
}

func _setup() -> void:
	$Air.connect("jumped", $Idle.jump_delay, "start")


func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		self.velocity = calculate_velocity(velocity, Vector3(0, JUMP_SPEED, 0), 1.0, Vector3.UP)
		_state_machine.transition_to("Move/Air")


func physics_process(delta: float) -> void:
	var move_direction: = get_move_direction()
	self.velocity = calculate_velocity(velocity, MAX_SPEED, delta, move_direction)
	self.velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	owner.rotation_degrees.y = _calculate_y_rotation(get_raw_move_direction())


func _calculate_y_rotation(move_direction: Vector3) -> float:
	var look_direction: = move_direction
	look_direction = Vector3(look_direction.x, 0, look_direction.z).normalized()
	return _rotations[str(look_direction)] if look_direction != Vector3.ZERO else owner.rotation_degrees.y


func set_velocity(value: Vector3) -> void:
	if owner == null:
		return

	velocity = value


static func calculate_velocity(
		old_velocity: Vector3, max_speed: Vector3, delta: float, move_direction: Vector3) -> Vector3:
	
	var new_velocity: = old_velocity
	new_velocity = new_velocity.linear_interpolate(move_direction.normalized() * max_speed, delta * 2.0)
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	new_velocity.z = clamp(new_velocity.z, -max_speed.z, max_speed.z)
	return new_velocity


static func get_move_direction() -> Vector3:
	return Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			-1.0,
			Input.get_action_strength("move_back") - Input.get_action_strength("move_front"))


static func get_raw_move_direction() -> Vector3:
	return Vector3(
			float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")),
			-1.0,
			float(Input.is_action_pressed("move_back")) - float(Input.is_action_pressed("move_front")))
