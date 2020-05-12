extends PanelContainer


onready var exp_tp: TextureProgress = $MarginContainer/VBoxContainer/EXPBar/HBoxContainer/CenterContainer/TextureProgress


func _ready() -> void:
	Events.connect("dummy_damaged", self, "_on_Dummy_damaged")


func _on_Dummy_damaged(experience: int) -> void:
	exp_tp.value += experience
