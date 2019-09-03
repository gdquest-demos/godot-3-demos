extends Area2D

func _on_area_entered(area: Area2D) -> void:
	visible = true

func _on_area_exited(area: Area2D) -> void:
	visible = false
