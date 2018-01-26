extends Node2D

var pos = Vector2()
var direction_from_player = Vector2()
var direction = Vector2()

func _ready():
	var Player = get_tree().get_root().get_node("./Game/Player")
	direction_from_player = (get_pos() - Player.get_pos()).normalized()
	direction = direction_from_player
	pos = get_pos()
