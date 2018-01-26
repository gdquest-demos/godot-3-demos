extends KinematicBody2D

onready var SpriteNode = get_node("Sprite")

var input_direction = 0
var direction = 1

var velocity = Vector2()
var motion = Vector2()

const MAX_SPEED = 600

var jump_count = 0
const MAX_JUMP_COUNT = 2

const JUMP_FORCE = 1000
const GRAVITY = 2800
const MAX_FALL_SPEED = 1400

# SLOPES
const MAX_WALKABLE_SLOPE_ANGLE = 45
const SLIDE_CANCEL_THRESHOLD = 1.0


func _ready():
	set_process(true)
	set_process_input(true)


func _input(event):
	if jump_count < MAX_JUMP_COUNT and event.is_action_pressed("jump"):
		velocity.y = -JUMP_FORCE
		jump_count += 1


func _process(delta):
	# DIRECTION
	if input_direction:
		direction = input_direction

	input_direction = Input.is_action_pressed("move_right") - Input.is_action_pressed("move_left")
	# Flipping the Player's Sprite
	if input_direction == - direction:
		var flip_character = false if input_direction == 1 else true
		SpriteNode.set_flip_h(flip_character)

	# SPEED
	velocity.x = input_direction * MAX_SPEED
	velocity.y += GRAVITY * delta
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED

	# We move the character to see if it's colliding or not
	motion = Vector2(velocity.x * delta, velocity.y * delta)
	var motion_remainder = move(motion)

	if is_colliding():
		var normal = get_collision_normal()
		# If it collides, we use the dot product to get the angle of the slope
		var slope_angle = rad2deg(acos(normal.dot(Vector2(0, -1))))

		# If the slope is < 45 deg, we landed on the ground, so we reset the jump count
		if slope_angle < MAX_WALKABLE_SLOPE_ANGLE:
			jump_count = 0
			# If the ground is not horizontal...
			if slope_angle > 0:
				# ...we have to revert the motion, and slide along the collider instead
				revert_motion()
				velocity.y = 0.0
				# However because of the gravity, if we don't add some kind of friction,
				# the character will slowly move down the slope. 
				# If he moves a little bit and there's no player input,
				# we stop him (set the motion_remainder to (0, 0))
				if get_travel().length() < SLIDE_CANCEL_THRESHOLD and velocity.x == 0:
					motion_remainder = Vector2()
		
		# The Vector2.slide method projects the vector along the other vector rotated by 90 degrees
		# In other words, it projects the motion on the slope, so we can move without colliding the same way
		var final_movement = normal.slide(motion_remainder)
		final_movement = move(final_movement)
