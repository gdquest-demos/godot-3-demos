extends Node

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("res://input_menu/InputMenu.tscn")
