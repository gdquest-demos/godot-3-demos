extends KinematicBody2D

"""
This is a very simple top down four way movement script.
"""

export (float) var speed
var movement: = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()

func move():
	movement = Vector2.ZERO
	if Input.is_action_pressed("down"):
		movement.y += 1
	if Input.is_action_pressed("up"):
		movement.y -= 1
	if Input.is_action_pressed("left"):
		movement.x -= 1
	if Input.is_action_pressed("right"):
		movement.x += 1
	movement = movement.normalized() * speed
	movement = move_and_slide(movement, Vector2.UP)
