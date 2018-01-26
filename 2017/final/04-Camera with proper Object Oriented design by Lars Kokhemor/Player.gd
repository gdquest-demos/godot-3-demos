extends KinematicBody2D

var direction = Vector2()
var speed = 0
var velocity = Vector2()
const MAX_SPEED = 400

var size

enum Direction {TOP, RIGHT, DOWN, LEFT}

func _ready():
	var sprite = get_node("Sprite")
	size = sprite.get_texture().get_size() * sprite.get_scale()
	set_fixed_process(true)


func _fixed_process(delta):
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


func turn_towards(_direction):
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
	