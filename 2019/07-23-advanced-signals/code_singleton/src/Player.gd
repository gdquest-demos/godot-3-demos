extends Position2D


onready var animation_player: AnimationPlayer = $AnimationPlayer

const DAMAGE := 25


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not animation_player.is_playing():
		animation_player.play("Attack")


func _attack(damage: int = DAMAGE) -> void:
	Events.emit_signal("player_attacked", damage)
