extends Node2D

onready var window_size = OS.get_window_size()
onready var player = get_node("Player")
onready var player_world_pos = get_player_world_pos()


func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)


func get_player_world_pos():
	# Converts the player position to the map he's on. Returns the map id/coordinates as Vector2
	return Vector2()


func update_camera():
	pass
