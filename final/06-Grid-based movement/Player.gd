extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

onready var grid = get_parent()

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if not is_moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), direction):
			target_pos = grid.update_child_pos(self, get_pos(), direction)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta

		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))

		if abs(velocity.x) > distance_to_target.x:
			velocity.x = target_direction.x * distance_to_target.x
			is_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = target_direction.y * distance_to_target.y
			is_moving = false

		move(velocity)
