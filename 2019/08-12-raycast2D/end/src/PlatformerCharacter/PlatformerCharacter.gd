extends KinematicBody2D

"""
This seems a little smelly, but I wanted to put together
a platformer controller for not only ground check but
also wall checking.  Feel free to change this in any way.
"""


export var walk_speed:= 500.0
export var gravity:= 100.0
export var jump_force: = 1600.0
export var jump_away_force: = 1600.0


var motion_vector:= Vector2.ZERO
var wall_normal:= Vector2.RIGHT

onready var ground_ray = $GroundRay
onready var right_ray = $WallRays/RightRay
onready var left_ray = $WallRays/LeftRay


func _process(delta):
	horizontal_move()
	vertical_move()
	facing()
	motion()


func facing():
	if motion_vector.x < 0:
		$Sprite.flip_h = true
	elif motion_vector.x > 0:
		$Sprite.flip_h = false


func vertical_move():
	if !ground_collide():
		if !wall_collide():
			motion_vector.y += gravity
		elif wall_collide():
			motion_vector.y = 0.5 * gravity
	else:
		motion_vector.y = 0
	if Input.is_action_just_pressed("fire") :
		if ground_collide():
			motion_vector.y = -jump_force
		if wall_collide():
			motion_vector.x += get_wall_normal().x * jump_away_force
			motion_vector.y = -jump_force


func horizontal_move():
	motion_vector.x = (
	Input.get_action_strength("right") - Input.get_action_strength("left")
	) * walk_speed


func motion():
	move_and_slide(motion_vector, Vector2.UP)


func ground_collide():
	return ground_ray.is_colliding()


func wall_collide():
	return left_ray.is_colliding() or right_ray.is_colliding()


func get_wall_normal():
	if right_ray.is_colliding():
		return right_ray.get_collision_normal()
	if left_ray.is_colliding():
		return left_ray.get_collision_normal()