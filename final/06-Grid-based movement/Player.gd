extends KinematicBody2D

const TOP	= Vector2(0, -1)
const RIGHT	= Vector2(1, 0)
const DOWN	= Vector2(0, 1)
const LEFT	= Vector2(-1, 0)

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var pos_on_grid = Vector2()
var is_moving = false

onready var grid = get_parent()

func _ready():
	set_fixed_process(true)
	pos_on_grid = grid.calculate_grid_pos(get_pos())
	var grid_to_world = grid.calculate_world_pos(pos_on_grid)
	set_pos(grid_to_world)


func _fixed_process(delta):
	var player_input = Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")

	if player_input and not is_moving:
		if Input.is_action_pressed("move_up"):
			direction = TOP
		elif Input.is_action_pressed("move_right"):
			direction = RIGHT
		elif Input.is_action_pressed("move_down"):
			direction = DOWN
		elif Input.is_action_pressed("move_left"):
			direction = LEFT

		if grid.is_cell_vacant(pos_on_grid + direction):
			pos_on_grid += direction
			target_pos = grid.calculate_world_pos(pos_on_grid)
			print(target_pos)
			is_moving = true

	speed = MAX_SPEED if is_moving else 0
	velocity = speed * direction * delta

	if target_pos != Vector2():
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))

		if abs(velocity.x) > distance_to_target.x:
			velocity.x = direction.x * distance_to_target.x
			is_moving = false
			target_pos = Vector2()
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = direction.y * distance_to_target.y
			is_moving = false
			target_pos = Vector2()

		move(velocity)
