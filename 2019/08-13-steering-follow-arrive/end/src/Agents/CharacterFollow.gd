extends KinematicBody2D
"""
Character that follows the mouse constantly
Uses the follow steering behavior
"""


onready var sprite: Sprite = $TriangleRed
onready var target: Node2D = get_node(target_path)
onready var follow_hint: Sprite = $FollowHint

const ARRIVE_THRESHOLD: = 100.0

export var max_speed: = 500.0
export var target_path: = NodePath()
export var follow_offset: = 100.0

var _velocity: = Vector2.ZERO


func _ready() -> void:
	follow_hint.set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	var target_global_position: Vector2 = target.global_position if target != self else get_global_mouse_position()

	var to_target = global_position.distance_to(target_global_position)
	if to_target < ARRIVE_THRESHOLD:
		return

	var follow_global_position: Vector2 = (
		target_global_position - (target_global_position - global_position).normalized() * follow_offset
		if to_target > follow_offset
		else global_position
	)
	follow_hint.global_position = follow_global_position


	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		follow_global_position,
		max_speed,
		200.0,
		10.0
	)
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()
