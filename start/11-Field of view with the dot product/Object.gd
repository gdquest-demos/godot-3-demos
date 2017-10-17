extends Node2D

var pos = Vector2()
var direction_from_player = Vector2()
var direction = Vector2()
onready var Player = get_tree().get_root().get_node("./Game/Player")

func _ready():	
	direction_from_player = (get_pos() - Player.get_pos()).normalized()
	direction = direction_from_player
	set_process(true)

func _process(delta):
	pos = get_pos()
	direction_from_player = (get_pos() - Player.get_pos()).normalized()