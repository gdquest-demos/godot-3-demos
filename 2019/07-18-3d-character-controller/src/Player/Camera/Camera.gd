extends Camera

var _target: Spatial

func _ready() -> void:
	_target = owner
	set_as_toplevel(true)
