# GridSnapping node
# Scene and code example by By Lars Kokemohr, dean of engineering at the school4games Berlin
# http://school4games.net/

# The previous examples break the single responsibility principle: The Game node is both the game, a grid-manager and a camera.
# This node, however has a single function: it snaps to the grid based on its parent's position
# With this design, Lars exploits the builtin Camera2d - we should always prioritize existing Nodes
# But splitting up the grid makes it reusable: It doesn't care about cameras or anything,
# It just snaps to grid cells based on its parent's position.
extends Node2D

var grid_pos
# You can control the grid's cell size from the Inspector tab in the editor
export(Vector2) var grid_size = Vector2(300,200)

# We use the parent, the Player here, in calculate_grid_pos
onready var parent = get_parent()

func _ready():
	set_process(true)
	# The node is set as toplevel to position itself independently from the player
	set_as_toplevel(true)
	update_grid_pos()

func _process(delta):
	# It always updates it position, moving the camera's target at the same time.
	# The camera2d node, with smoothing on, will smoothly move to this node's position in the world.
	update_grid_pos()

func update_grid_pos():
	var new_pos = calculate_grid_pos()
	if grid_pos != new_pos:
		grid_pos = new_pos
		# Each function has a precise role. update_grid_pos only updates the stored position
		# jump_to_grid_pos moves the Node in the world
		jump_to_grid_pos()

func calculate_grid_pos():
	var x = round(parent.get_pos().x / grid_size.x)
	var y = round(parent.get_pos().y / grid_size.y)
	return Vector2(x,y)

func jump_to_grid_pos():
	set_pos(Vector2(grid_pos.x * grid_size.x, grid_pos.y * grid_size.y))
