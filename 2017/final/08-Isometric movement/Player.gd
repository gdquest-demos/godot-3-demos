extends KinematicBody2D

const SPEED = 400
var motion = Vector2()


# Converts any Vector2 coordinates or motion from the cartesian to the isometric system
func cartesian_to_isometric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)


# useful to convert mouse coordinates back to screen-space, and detect where the player wants to know.
# If we want to add mouse-based controls, we'll need this function
func isometric_to_cartesian(iso):
	var cart_pos = Vector2()
	cart_pos.x = (iso.x + iso.y * 2) / 2
	cart_pos.y = - iso.x + cart_pos.x
	return cart_pos


func _fixed_process(delta):
	# Everything works like you're used to in a top-down game
	var direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction += Vector2(0, -1)
	elif Input.is_action_pressed("move_bottom"):
		direction += Vector2(0, 1)

	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1, 0)
	elif Input.is_action_pressed("move_right"):
		direction += Vector2(1, 0)

	motion = direction.normalized() * SPEED * delta
	# Isometric movement is movement like you're used to, converted to the isometric system
	motion = cartesian_to_isometric(motion)
	move(motion)

func _ready():
	set_fixed_process(true)
