extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var world_target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var type
var grid


func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_process(true)


func _process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	if not is_moving and direction != Vector2():
		# if player is not moving and has no direction
		# then set the target direction
		target_direction = direction.normalized()

		if grid.is_cell_vacant(position, direction):
			world_target_pos = grid.update_child_pos(position, direction, type)
			is_moving = true

	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta

		var distance_to_target = position.distance_to(world_target_pos)
		var move_distance = velocity.length()

		# Set the last movement distance to the distance to the target
		# this will make the player stop exaclty on the target
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false

		move_and_collide(velocity)

