extends KinematicBody2D
"""
Player-controled character. Moves in 4 directions
"""

signal fired_shot


export var speed: = 500.0


onready var pointer:= $Pointer
onready var ray:=$Pointer/RayCast2D


func _process(delta):
	move()


func _unhandled_input(event):
	if event.is_action_pressed("fire") and ray.is_colliding():
		emit_signal("fired_shot", ray.get_collision_point())


func move()->void:
	var direction: = Vector2.ZERO
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
	var velocity = direction * speed
	move_and_slide(velocity, Vector2.UP)
	if velocity != Vector2.ZERO:
		rotate_pointer(velocity)


func rotate_pointer(point_direction: Vector2)->void:
	var temp = rad2deg(atan2(point_direction.y, point_direction.x))
	pointer.rotation_degrees = temp


