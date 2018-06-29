extends "state.gd"

var knockback_direction = Vector2()

func enter():
	owner.get_node("AnimationPlayer").play("stagger")
	owner.get_node("Health").take_damage(4)

func _on_animation_finished(anim_name):
	emit_signal("finished", "previous")
