extends Spatial

signal level_completed()

func _on_Goal_body_entered(body):
	if body is Player:
		emit_signal("level_completed")
