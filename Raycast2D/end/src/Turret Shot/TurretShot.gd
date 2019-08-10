extends Area2D

export var speed:= 700

var direction:= Vector2.ZERO


func setup(new_direction: Vector2):
	direction = new_direction


func _process(delta):
	position += direction.normalized() * speed * delta


func _on_TurretShot_area_entered(area):
	queue_free()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_TurretShot_body_entered(body):
	queue_free()
