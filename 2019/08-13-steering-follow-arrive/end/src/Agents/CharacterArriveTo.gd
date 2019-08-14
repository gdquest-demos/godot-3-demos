extends KinematicBody2D


onready var sprite: Sprite = $TriangleRed
onready var camera: Camera2D = $Camera2D

const DISTANCE_THRESHOLD: = 3.0

export var max_speed: = 500.0

var target_global_position: = Vector2.ZERO setget set_target_global_position
var _velocity: = Vector2.ZERO

var _is_following: = false


func _ready() -> void:
	set_physics_process(false)
	camera.set_as_toplevel(true)
	camera.global_position = global_position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		self.target_global_position = get_global_mouse_position()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		self.target_global_position = get_global_mouse_position()
	if global_position.distance_to(target_global_position) < DISTANCE_THRESHOLD:
		set_physics_process(false)
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		target_global_position,
		max_speed
	)
	_velocity = move_and_slide(_velocity)
	sprite.rotation = _velocity.angle()


func set_target_global_position(value: Vector2) -> void:
	target_global_position = value
	camera.global_position = value
	set_physics_process(true)
