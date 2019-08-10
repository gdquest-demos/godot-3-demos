extends KinematicBody2D
"""
Player-controled character. Moves in 4 directions

rotates a pointer at its "feet" to show which direciton
it is pointing.

Uses a raycast to signal the scene to generate a particle 
to simulate hitscan weapons.  
"""

export var speed: = 500.0


var colliding:= false
var hit_position: = Vector2.ZERO


onready var ray = $Pointer/RayCast2D
onready var pointer = $Pointer


signal make_hit_effect
signal pointer_direction

func _process(delta):
	get_collision_info()
	move()
	shoot()


func move():
	var direction: = Vector2.ZERO
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
	var velocity = direction * speed
	move_and_slide(velocity, Vector2.UP)
	if direction.length() > 0:
		change_pointer_direction(direction)


func shoot():
	if Input.is_action_just_pressed("fire") and colliding:
		emit_signal("make_hit_effect", hit_position)


func change_pointer_direction(direction: Vector2):
	var temp = rad2deg(atan2(direction.y, direction.x))
	pointer.rotation_degrees = temp


func get_collision_info():
	colliding = ray.is_colliding()
	if colliding:
		hit_position = ray.get_collision_point()


