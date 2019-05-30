extends Node2D

onready var grid = get_parent()

func _ready():
	modulate = Color( 1, 0.2, 0, 0.2 )

func _draw():
	var LINE_COLOR = Color(255, 255, 255)
	var LINE_WIDTH = 2
#	var window_size = OS.get_window_size()

	for x in range(grid.cell_quadrant_size + 1):
		var col_pos = x * grid.cell_size.x
		var limit = grid.grid_size.y * grid.cell_size.y
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, limit), LINE_COLOR, LINE_WIDTH)
	for y in range(grid.cell_quadrant_size + 1):
		var row_pos = y * grid.cell_size.y
		var limit = grid.grid_size.x * grid.cell_size.x
		draw_line(Vector2(0, row_pos), Vector2(limit, row_pos), LINE_COLOR, LINE_WIDTH)
