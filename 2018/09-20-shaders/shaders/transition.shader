shader_type canvas_item;
render_mode unshaded;

uniform float cutoff : hint_range(0.0, 1.0);
uniform float smooth_size : hint_range(0.0, 1.0);
uniform sampler2D mask : hint_albedo;

uniform vec4 color : hint_color;

void fragment()
{
	float value = texture(mask, UV).r;
	float alpha = smoothstep(cutoff, cutoff + smooth_size, value * (1.0 - smooth_size) + smooth_size);
	COLOR = vec4(color.rgb, alpha);
}

//	alpha = step(value, cutoff);
//	if (value < cutoff) { 
//		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
//	} 
//	else if (value < cutoff + 0.1) { 
//		COLOR = vec4(0.0, 0.0, 0.0, (cutoff + 0.1 - value) / 0.1);
//	}
//	else {
//		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
//	}