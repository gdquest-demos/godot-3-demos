tool
extends Sprite

func calculate_aspect_ratio():
	material.set_shader_param("aspect_ratio", scale.y / scale.x)
