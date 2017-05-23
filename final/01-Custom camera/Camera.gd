# Custom camera
extends Node


onready var screen_size = Vector2(Globals.get("display/width"), Globals.get("display/height")) 
onready var player = get_node("Player")
onready var last_player_pos = player.get_pos()


func _ready():
	# Center the camera on the player
	var canvas_transform = get_viewport().get_canvas_transform()
	# canvas_transform is of type Matrix32. That's an array of 3 Vector2
	# canvas_transform[2] controls the camera's position
	# we center it on the player
	canvas_transform[2] = player.get_pos() - screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)

	
func offset_viewport(amount = Vector2(0,0)):
	# Translate the camera, using a Vector2
	# returns a Matrix32
	var transform = get_viewport().get_canvas_transform()
	transform[2] += amount
	return transform


func update_camera():
	# Checks if the player moved since last call, and if so, translate the camera accordingly
	# Called when the move signal is emitted by Player
	var player_offset = last_player_pos - player.get_pos()
	last_player_pos = player.get_pos()
	
	if player_offset != Vector2(0, 0):
		var offset = offset_viewport(player_offset)
		get_viewport().set_canvas_transform(offset)
	return player_offset
