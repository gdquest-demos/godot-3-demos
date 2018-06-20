extends VBoxContainer

signal amplitude_changed

onready var LABEL_START_TEXT = $Label.text
onready var amplitude = $Slider.value setget set_amplitude

func _on_Slider_value_changed(value):
	self.amplitude = value


func set_amplitude(value):
	$Label.text = LABEL_START_TEXT + str(value)
	emit_signal('amplitude_changed', value)
	amplitude = value
