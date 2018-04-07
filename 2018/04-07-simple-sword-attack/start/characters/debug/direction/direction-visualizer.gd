extends Position2D

func _ready():
	var player_node = $'..'
	player_node.connect("direction_changed", self, '_on_Player_direction_changed')
	set_process(false)


func _on_Player_direction_changed(direction):
	rotation = direction.angle()
	if direction == Vector2(0, -1):
		visible = false
	else:
		visible = true
