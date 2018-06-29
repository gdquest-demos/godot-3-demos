extends Area2D

signal item_tracked(item)
signal item_collected(item)
signal item_untracked

var _tracked_item = null
var _overlapped_items = []

func _input(event):
	if event.is_action_pressed("collect"):
		collect_item(_tracked_item)

func collect_item(node):
	if not _tracked_item:
		return
	emit_signal("item_collected", node)
	update_tracked_item()
	node.queue_free()

func _on_area_entered(area):
	_overlapped_items.append(area)
	update_tracked_item()

func _on_area_exited(area):
	_overlapped_items.erase(area)
	update_tracked_item()

# Can't use get_overlapping_areas as _on_area_exited, 
# the area still counts as overlapping
func update_tracked_item():
	if not _overlapped_items:
		_tracked_item = null
		emit_signal("item_untracked")
	else:
		_tracked_item = _overlapped_items[0]
		emit_signal("item_tracked", _tracked_item)
