extends KinematicBody2D

var direction = Vector2()

var speed = 0
const MAX_SPEED = 400

var velocity = Vector2()

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_left_alt"):
		direction.x = -1
	elif Input.is_action_pressed("move_right_alt"):
		direction.x = 1

	if Input.is_action_pressed("move_up_alt"):
		direction.y = -1
	elif Input.is_action_pressed("move_down_alt"):
		direction.y = 1

	if direction != Vector2():
		speed = MAX_SPEED
	else:
		speed = 0

	velocity = speed * direction.normalized() * delta

	move(velocity)

func save():
	var save_dict = {
		pos={
			x=get_pos().x,
			y=get_pos().y
		}
	}
	return save_dict