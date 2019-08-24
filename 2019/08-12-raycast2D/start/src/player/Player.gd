extends KinematicBody2D
"""
Player-controled character. Moves in 4 directions
"""

export var speed: = 500.0


func _process(delta):
	move()


func move()->void:
	var direction: = Vector2.ZERO
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
	var velocity = direction * speed
	move_and_slide(velocity, Vector2.UP)


