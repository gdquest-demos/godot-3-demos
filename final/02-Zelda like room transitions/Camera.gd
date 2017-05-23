extends Node2D

onready var screen_size = Vector2(Globals.get("display/width"), Globals.get("display/height")) 
onready var player = get_node("Player")
onready var last_player_pos = player.get_pos()

onready var player_world_pos = get_player_world_pos()

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * screen_size
	get_viewport().set_canvas_transform(canvas_transform)


# This is a basic solution to the problem. Another way would be to divide the world using a grid
# and to check on which cell the player is. With each map containing a constant amount of cells,
# we can calculate where the player is in the world
# (hint: the tileset we use for the background is a grid!)
func update_camera():
	# Checks if the player is touching or moved beyond the view rectangle's edges
	# If so, offset the camera in this direction
	var new_player_world_pos = get_player_world_pos()
	var transform = Matrix32()
	
	if new_player_world_pos != player_world_pos:
		player_world_pos = new_player_world_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = - player_world_pos * screen_size
		get_viewport().set_canvas_transform(transform)
	return transform


func get_player_world_pos():
	# Converts the player position to the map he's on. Returns the coordinates (Vector2) in maps
	# Vector2(1, 1) <=> screen_width, screen_height
	var pos = player.get_pos() - player.size / 2
	var x = floor(pos.x / screen_size.x)
	var y = floor(pos.y / screen_size.y)
	return Vector2(x, y)
