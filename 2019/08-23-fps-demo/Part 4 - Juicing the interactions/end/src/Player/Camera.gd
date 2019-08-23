extends Camera

onready var shake_tween:=$ShakeTween


func screen_kick(intensity: float, duration: float)->void:
	var temp_intensity = rand_range(intensity/2, intensity)
	var temp_rotation = rotation_degrees + Vector3(temp_intensity, 0,  0)
	shake_tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 
		temp_rotation, duration, Tween.TRANS_CIRC, Tween.EASE_OUT)
	shake_tween.start()