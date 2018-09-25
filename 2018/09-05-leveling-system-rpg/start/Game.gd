extends Node

onready var _character = $Character
onready var _label = $Interface/Label
onready var _bar = $Interface/ExperienceBar

func _ready():
	_bar.initialize(_character.experience, _character.experience_required)
	_label.update_text(_character.level, _character.experience, _character.experience_required)

func _input(event):
	if not event.is_action_pressed('ui_accept'):
		return
	_character.gain_experience(34)
	_label.update_text(_character.level, _character.experience, _character.experience_required)
