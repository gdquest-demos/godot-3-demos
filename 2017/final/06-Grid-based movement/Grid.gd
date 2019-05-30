# Collection of functions to work with a Grid. Stores all its children in the grid array
extends TileMap

enum {EMPTY, PLAYER, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)

var grid = []
onready var Obstacle = preload("res://Obstacle.tscn")
onready var Player = preload("res://Player.tscn")
const PLAYER_STARTPOS = Vector2(4,4)


func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(EMPTY)

	# Player
	var new_player = Player.instance()
	new_player.position = map_to_world(PLAYER_STARTPOS) + half_tile_size
	grid[PLAYER_STARTPOS.x][PLAYER_STARTPOS.y] = PLAYER
	add_child(new_player)

	# Obstacles
	var positions = []
	for n in range(5):
		var placed = false
		while not placed:
			var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in positions:
					positions.append(grid_pos)
					placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)


#func get_cell_entity_type(pos=Vector2()):
#	return grid[pos.x][pos.y]


# Check if cell at direction is vacant
func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			return true if grid[target_grid_pos.x][target_grid_pos.y] == EMPTY else false
	return false


# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):

	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction

	# remove player from current grid location
	grid[this_grid_pos.x][this_grid_pos.y] = EMPTY

	# place player on new grid location
	grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos
