extends Node

onready var touches_label : Label = $Container/VBoxContainer/Touches

var touch_count := 0


func _ready() -> void:
	update_touches_label()


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		touch_count += 1
		update_touches_label()


func update_touches_label() -> void:
	touches_label.text = str(touch_count)
