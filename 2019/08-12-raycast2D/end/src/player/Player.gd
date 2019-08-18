extends KinematicBody2D
"""
Player-controled character. Moves in 4 directions

rotates a pointer at its "feet" to show which direciton
it is pointing.

Uses a raycast to signal the scene to generate a particle 
to simulate hitscan weapons.  
"""

signal shot_bullet

var colliding:= false

onready var ray = $Pointer/RayCast2D
onready var pointer = $Pointer

export var speed: = 500.0

func _unhandled_input(event: InputEvent)->void:
	if event.is_action_pressed("fire") and ray.is_colliding():
		shoot()

func _process(delta):
	move()


func move()->void:
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	var velocity = direction * speed
	move_and_slide(velocity)
	
	if direction != Vector2.ZERO:
		change_pointer_direction(direction)


func shoot()->void:
	emit_signal("shot_bullet",ray.get_collision_point())


func change_pointer_direction(direction: Vector2)->void:
	var temp = rad2deg(atan2(direction.y, direction.x))
	pointer.rotation_degrees = temp



