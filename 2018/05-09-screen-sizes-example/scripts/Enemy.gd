extends Node2D

const SPEED = 200

var direction = Vector2()

func _process(delta):
	position += SPEED * direction * delta

# Delete the node when it moves outside the view
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
