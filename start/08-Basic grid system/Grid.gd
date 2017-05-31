extends TileMap

var tile_size
var half_tile_size

var grid_size
var grid = []

# onready var Obstacle = preload("res://Obstacle.tscn")


func _ready():
	# 1. Create the grid Array
	# 2. Create obstacles
	pass


func is_cell_vacant():
	# Return true if the cell is vacant, else false
	pass


func update_child_pos(child, new_pos, direction):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	pass
