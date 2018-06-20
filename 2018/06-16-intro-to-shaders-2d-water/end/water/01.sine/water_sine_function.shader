shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform vec2 time_factor = vec2(2.0, 3.0);
uniform vec2 offset_factor = vec2(5.0, 2.0);
uniform vec2 amplitude = vec2(0.05, 0.05);

vec2 calculate_wave_uv_offset(in float time, vec2 source_uvs, vec2 time_multiplier, vec2 waves_scale) {
	return vec2(
		sin(time * time_multiplier.x + (source_uvs.x + source_uvs.y) * waves_scale.x),
		cos(time * time_multiplier.y + (source_uvs.x + source_uvs.y) * waves_scale.y)
	);
}

void fragment() {
	vec2 tiled_uvs = UV * tile_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 wave_uv_offset = calculate_wave_uv_offset(TIME, tiled_uvs, time_factor, offset_factor);
	
	COLOR = texture(TEXTURE, tiled_uvs + wave_uv_offset * amplitude);
//	COLOR = vec4(wave_uv_offset, 0.0, 1.0);
}