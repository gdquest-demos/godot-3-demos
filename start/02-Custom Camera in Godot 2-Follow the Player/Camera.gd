# Custom camera
extends Node

onready var screen_size = Vector2(Globals.get("display/width"), Globals.get("display/height"))
onready var player = get_node("Player")

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player.get_pos() - screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)


func update_camera():
	print('moved!')