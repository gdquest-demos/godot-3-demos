extends KinematicBody2D

# We need the same variables as usual to produce a smooth motion. However, it's stored as the target_motion, the move vector the car is steering towards.
var direction = Vector2()
var speed = 0
var acceleration = 1800
var decceleration = 3000

var motion = Vector2()
var target_motion = Vector2()
var steering = Vector2()

# The mass is an arbitrary divider used to add some drag to the movement. The higher it is, the longer the car takes to change its motion.
const MASS = 2

const MAX_SPEED = 600

# The Skin is a reference to the Sprite node attached to the Car. We need it to set the sprite's angle (see the end of the script)
var Skin = null
var target_angle = 0

func _ready():
	Skin = get_node("Sprite")
	set_fixed_process(true)


func _fixed_process(delta):
	# The input works the same way as in the previous top-down demo. We reset the direction to (0, 0) on every frame and modify the vector based on the input. With 4 keys supported, you get 8 possible directions.
	direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1

	# If the direction vector is not equal to (0, 0), in other words if the player wants to go in one of the 8 possible directions, we accelerate the car. Otherwise we deccelerate.
	if direction != Vector2():
		speed += acceleration * delta
	else:
		speed -= decceleration * delta

	# Because we always accelerate or deccelerate, we use the clamp function to ensure the speed never goes negative or beyond the MAX_SPEED constant.
	speed = clamp(speed, 0, MAX_SPEED)

	# If you don't normalize the direction, the player will move about 1.4 times faster in diagonals. That is due to the fact that a vector of length 1 on the X axis and 1 on the Y axis has a diagonal of length sqrt(1^2 + 1^2)
	target_motion = speed * direction.normalized() * delta
	# The steering is a vector starting at the tip of the motion vector and ending at the tip of the target_motion vector. In other words, the current motion + steering = target_motion. To get the steering effect, we divide the steering vector by the MASS constant and add it to the motion. You can see in the game how the yellow vector lags behind the green one.
	steering = target_motion - motion

	# The steering vector is too long by default, so we normalize it to get better control over it. That's partly because in this script, we're dealing with motion directly, not using velocity as an intermediate step.
	# Velocity means speed in a given direction (it's still in pixels/s) while the motion is the amount of pixels you'll move during one frame (it's in pixels, the velocity * delta)
	if steering.length() > 1:
		steering = steering.normalized()

	motion += steering / MASS

	# If the character isn't meant to move, we also reset the motion. It's mostly important to draw the vectors, as the MovementVisualizer draws the motion vector on screen.
	if speed == 0:
		motion = Vector2()

	move(motion)
	# And that's where we set the car sprite's angle, in Radians. The arc tangent of a vector's coordinates gives you its angle. With the steering setup, we can use that angle on the sprite and it works well for free! There are some limitations when you go to opposite directions, but that is linked to the car's motion rather than these 2 lines setting the angle.
	# Note we only change the angle when there's motion, otherwise the car's angle is reset to 0 when it stops.
	if motion != Vector2():
		target_angle = atan2(motion.x, motion.y) - PI/2
		Skin.set_rot(target_angle)
