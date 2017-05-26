# Basic top-down character controller. Instantly sets the speed to MAX_SPEED. No acceleration or decceleration
extends KinematicBody2D

var direction = Vector2()
var speed = 0
var velocity = Vector2()
const MAX_SPEED = 400

signal move

enum Direction {TOP, RIGHT, DOWN, LEFT}


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	# is_moving is a helper boolean. It's common to use this check several times throughout the code block.
	var is_moving = Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")

	if is_moving:
		speed = MAX_SPEED

		if Input.is_action_pressed("move_right"):
			turn_towards(RIGHT)
		elif Input.is_action_pressed("move_left"):
			turn_towards(LEFT)
		elif Input.is_action_pressed("move_up"):
			turn_towards(TOP)
		elif Input.is_action_pressed("move_down"):
			turn_towards(DOWN)
	else:
		speed = 0
	
	velocity = speed * direction * delta
	move(velocity)
	if is_moving:
		emit_signal("move")


func turn_towards(_direction):
	# This method allows us to use the enum constants TOP, DOWN, LEFT and RIGHT to set the player direction, which is easier to read than using Vector2s every time.
	if _direction == TOP:
		direction = Vector2(0, -1)
	elif _direction == DOWN:
		direction = Vector2(0, 1)
	elif _direction == LEFT:
		direction = Vector2(-1, 0)
		get_node("Sprite").set_flip_h(false)
	elif _direction == RIGHT:
		direction = Vector2(1, 0)
		get_node("Sprite").set_flip_h(true)
	