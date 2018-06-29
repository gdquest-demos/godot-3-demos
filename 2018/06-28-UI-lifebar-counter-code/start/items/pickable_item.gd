extends Area2D

func _on_area_entered(area):
	modulate = Color("#6668ff")

func _on_area_exited(area):
	modulate = Color("#ffffff")
