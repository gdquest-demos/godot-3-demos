extends Node

signal rupees_changed(count)

export(int) var rupees = 0

func _ready():
	emit_signal("rupees_changed", rupees)

func _on_CollectArea_item_collected(item):
	rupees += 1
	emit_signal("rupees_changed", rupees)
