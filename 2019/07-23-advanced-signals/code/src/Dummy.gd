extends Position2D


signal damaged(experience)

onready var hp_tp: TextureProgress = $HPBar/HBoxContainer/CenterContainer/TextureProgress
onready var animation_player: AnimationPlayer = $AnimationPlayer

const EXP_MIN := 5
const EXP_MAX := 10


func _on_Player_attacked(damage: int) -> void:
	animation_player.play("React")
	hp_tp.value -= damage
	hp_tp.value = hp_tp.value if hp_tp.value > 0.0 else 100.0


func _damaged() -> void:
	emit_signal("damaged", EXP_MAX if hp_tp.value >= 100.0 else EXP_MIN)
