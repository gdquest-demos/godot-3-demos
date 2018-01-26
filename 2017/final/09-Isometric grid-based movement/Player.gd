# Compared to the grid example (final/06), only a few lines changed
# The Grid (TileMap) node supports isometric projection out of the box, 
# but we still have to calculate isometric motion by ourselves.
# The player has a cartesian_to_isometric method that converts the coordinates,
# explained in details in the Intro to Isometric Worlds tutorial (https://youtu.be/KvSjJ-kdGio)
extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 1200

var speed = 0
var motion = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var type
var grid


func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)

func _ready():
	# The Player is now a child of the YSort node, so we have to go 1 more step up the node tree
	grid = get_parent().get_parent()
	type = grid.PLAYER
	set_fixed_process(true)


func _fixed_process(delta):
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
		target_direction = direction.normalized()
		if grid.is_cell_vacant(get_pos(), direction):
			target_pos = grid.update_child_pos(get_pos(), direction, type)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		# We have to convert the player's motion to the isometric system.
		# The target_direction is normalized a few lines above so the player moves at the same speed in all directions.
		motion = cartesian_to_isometric(speed * target_direction * delta)

		var pos = get_pos()
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = motion.length()

		# In the previous example, the player could land on floating positions
		# We force him to stop exactly on the target by setting the position instead of using the move method
		# As the grid handles the "collisions", we can use the two functions interchangeably:
		# move(motion) <=> set_pos(get_pos() + motion)
		if move_distance > distance_to_target:
			set_pos(target_pos)
			is_moving = false
		else:
			move(motion)
