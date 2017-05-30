# Collection of functions to work with a Grid. Stores all its children in the grid array
extends Node2D

var tile_size = Vector2(96, 96)
var half_tile_size = tile_size / 2
var grid_size = Vector2(12, 12)

var grid = []


func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

	for child in get_children():
		var data = get_child_data(child)
		var pos = data[0]
		var path = data[1]
		grid[pos.x][pos.y] = path
	

func get_cell_content(pos=Vector2()):
	return grid[pos.x][pos.y]


func get_child_data(child):
	var pos = calculate_grid_pos(child.get_pos())
	var path = child.get_name()
	return [pos, path]


func calculate_grid_pos(pos=Vector2()):
	var x = round((pos.x - half_tile_size.x) / tile_size.x)
	var y = round((pos.y - half_tile_size.y) / tile_size.y)
	return Vector2(x, y)


func calculate_world_pos(grid_pos=Vector2()):
	var x = grid_pos.x * tile_size.x + half_tile_size.x
	var y = grid_pos.y * tile_size.y + half_tile_size.y
	return Vector2(x, y)


func is_cell_vacant(pos=Vector2()):
	if 0 < pos.x < grid_size.x and 0 < pos.y < grid_size.y:
		return true if grid[pos.x][pos.y] == null else false
	return false


func _draw():
	var LINE_COLOR = Color(255, 255, 255)
	var LINE_WIDTH = 2
	var window_size = OS.get_window_size()

	for x in range(grid_size.x + 1):
		var row_pos = x * tile_size.x
		draw_line(Vector2(0, row_pos), Vector2(window_size.x, row_pos), LINE_COLOR, LINE_WIDTH)
	for y in range(grid_size.y + 1):
		var col_pos = y * tile_size.y
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, window_size.y), LINE_COLOR, LINE_WIDTH)
