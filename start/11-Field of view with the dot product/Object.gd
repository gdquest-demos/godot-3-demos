extends Node2D

var pos = Vector2()
var direction = Vector2()

func _ready():
	var Player = get_tree().get_root().get_node("./Game/Player")
	direction = (get_pos() - Player.get_pos()).normalized()
	pos = get_pos()
