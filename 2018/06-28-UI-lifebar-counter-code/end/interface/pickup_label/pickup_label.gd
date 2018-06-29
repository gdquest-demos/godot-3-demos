extends NinePatchRect

var _offset

func _ready():
	_offset = Vector2(rect_size.x / 2, - rect_size.y - 20.0)

func _on_CollectArea_item_untracked():
	visible = false

func _on_CollectArea_item_tracked(item):
	visible = true
	rect_position = item.global_position + _offset
