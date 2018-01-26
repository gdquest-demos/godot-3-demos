# Camera that smoothly transitions from a room to the next, using steering (we apply a force so it slows down as it approaches its target)
extends Node2D

onready var window_size = OS.get_window_size()
onready var player = get_node("Player")
onready var player_grid_pos = get_player_grid_pos()

var target_pos = Vector2()
var speed = 1200
var pos = Vector2()
var slow_distance = 200
var velocity = Vector2()

func _ready():
	# Initialize the camera's position. It's the center of the room the player is in.
	# It's very important to store the position in a member variable, pos here
	pos = move_to(player_grid_pos * window_size + window_size/2)


func _process(delta):
	# If the camera is far from its target, it will move at its maximum speed.
	# We will only apply the counter force and slow it down as it approaches the target.
	var distance_to_target = pos.distance_to(target_pos)
	
	if distance_to_target < slow_distance:
		# The only difference in velocity is the division at the end to smoothly slow the camera down
		velocity = (target_pos - pos).normalized() * speed * delta * (distance_to_target / slow_distance)
	else:
		# We create a vector pointing towards the target, normalize it so it has a length of 1
		# Once we multiply it by speed * delta, we ensure that the camera will move at speed px/s
		velocity = (target_pos - pos).normalized() * speed * delta
	pos = move_to(pos + velocity)
	
	# The camera will jitter around the target if we don't force it to stop at some point
	if distance_to_target < 2:
		pos = move_to(target_pos)
		set_process(false)


func move_to(new_pos):
	# centers the camera on new_pos. Returns the new_position so we can store it in the pos member variable
	var transform = get_viewport().get_canvas_transform()
	transform[2] = -new_pos + window_size/2
	get_viewport().set_canvas_transform(transform)
	return new_pos


func update_camera():
	# Similar to example 02, but we don't move the camera. We just set its target_pos
	# Then we set it to process every frame so we can move it smoothly, independently from the player
	var new_player_grid_pos = get_player_grid_pos()
	
	if new_player_grid_pos != player_grid_pos:
		player_grid_pos = new_player_grid_pos
		target_pos = new_player_grid_pos * window_size + window_size/2
		set_process(true)
	return new_player_grid_pos


func get_player_grid_pos():
	# Converts the player position in px to his position on the world grid
	var pos = player.get_pos() - player.size / 2
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)