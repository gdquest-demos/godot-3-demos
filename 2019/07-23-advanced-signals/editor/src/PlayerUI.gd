extends PanelContainer


onready var exp_tp: TextureProgress = $MarginContainer/VBoxContainer/EXPBar/HBoxContainer/CenterContainer/TextureProgress


func _on_Dummy_damaged(experience: int) -> void:
	exp_tp.value += experience
