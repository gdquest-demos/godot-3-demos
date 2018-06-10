extends TileMap

enum CELL_TYPES { ACTOR, OBSTACLE, OBJECT }

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)


func get_cell_pawn(cell, type = ACTOR):
	for node in get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_tile_id = get_cellv(cell_target)
	match cell_tile_id:
		-1:
			set_cellv(cell_target, ACTOR)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size / 2
		OBJECT, ACTOR:
			var pawn_name = get_cell_pawn(cell_target, cell_tile_id).name
			print("Cell %s contains %s" % [cell_target, pawn_name])
