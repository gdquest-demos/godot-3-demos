extends Area2D

export(float) var SPEED = 1500
export(float) var DAMAGE = 15

var direction = 0

func _ready():
	set_as_toplevel(true)

func _process(delta):
	position.x += direction * SPEED * delta

func _on_body_entered(body):
	if body.is_a_parent_of(self):
		return
	if not body.is_in_group('players'):
		return
	body.damage(DAMAGE)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
