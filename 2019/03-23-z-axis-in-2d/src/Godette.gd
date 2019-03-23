extends KinematicBody

const FLOOR_NORMAL = Vector3(0.0, 1.0, 0.0)

export var speed := 7.0
export var gravity := 30.0
export var jump_force := 12.0

var velocity_y := 0.0

func _physics_process(delta: float) -> void:
	var direction_ground := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
	
	if not is_on_floor():
		velocity_y -= gravity * delta
	
	var velocity = Vector3(
		direction_ground.x * speed,
		velocity_y,
		direction_ground.y * speed)
	move_and_slide(velocity, FLOOR_NORMAL)
	
	if is_on_floor() or is_on_ceiling():
		velocity_y = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		velocity_y = jump_force
