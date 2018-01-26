extends KinematicBody2D

var direction = Vector2()
var speed = 0
export var acceleration = 200
var decceleration = 3000

var velocity = Vector2()
var target_velocity = Vector2()
var steering = Vector2()
const MASS = 2

const MAX_SPEED = 600

var Skin = null
var size = Vector2()

func _ready():
	Skin = get_node("Sprite")
	size = Skin.get_texture().get_size() * Skin.get_scale()
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	
	if direction != Vector2():
		speed += acceleration * delta
	else:
		speed -= decceleration * delta

	speed = clamp(speed, 0, MAX_SPEED)
	
	target_velocity = speed * direction.normalized() * delta
	steering = target_velocity - velocity

	if steering.length() > 1:
		steering = steering.normalized()
	
	velocity += steering / MASS

	if speed == 0:
		velocity = Vector2()

	move(velocity)