extends KinematicBody2D

var direction = Vector2()

var speed = 0
const MAX_SPEED = 400

var velocity = Vector2()
export(int) var max_health = 6


enum STATES {IDLE, WALKING}
var state = IDLE


func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if direction != Vector2():
		speed = MAX_SPEED
		state = WALKING
	else:
		speed = 0
		state = IDLE

	velocity = speed * direction.normalized() * delta

	move(velocity)


func is_idle():
	return state == IDLE
