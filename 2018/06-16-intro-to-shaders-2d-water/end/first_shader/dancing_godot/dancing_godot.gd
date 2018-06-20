tool
extends TextureRect

onready var amplitude = material.get_shader_param("amplitude")
func _ready():
	assert amplitude != null


func _on_AmplitudeController_amplitude_changed(new_value):
	amplitude.x = new_value
	material.set_shader_param("amplitude", amplitude)
