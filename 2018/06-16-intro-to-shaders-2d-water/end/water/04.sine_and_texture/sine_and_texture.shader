shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform sampler2D uv_offset_texture : hint_black;
uniform vec2 uv_offset_scale = vec2(0.2, 0.2);
uniform float wave_size = 0.1;

uniform float time_scale = 0.05;

uniform float sine_time_scale = 0.03;
uniform vec2 sine_offset_scale = vec2(0.4, 0.4);
uniform float sine_wave_size = 0.4;

vec2 calculate_sine_waves_offset(in float time, vec2 source_uvs, float time_multiplier, vec2 waves_scale) {
	float time_offset = time * time_multiplier + (source_uvs.x + source_uvs.y);
	return vec2(
		sin(time_offset / waves_scale.x),
		cos(time_offset / waves_scale.y)
	);
}

void fragment() {
	vec2 base_uv_offset = UV * uv_offset_scale;
	base_uv_offset += TIME * time_scale;
	
	vec2 texture_based_offset = texture(uv_offset_texture, base_uv_offset).rg;
	texture_based_offset = texture_based_offset * 2.0 - 1.0;
	
	vec2 adjusted_uv = UV * tile_factor;
	adjusted_uv.y *= aspect_ratio;

	vec2 sine_waves_offset = calculate_sine_waves_offset(TIME, adjusted_uv, sine_time_scale, sine_offset_scale);

	COLOR = texture(TEXTURE, adjusted_uv + texture_based_offset * wave_size + sine_waves_offset * sine_wave_size);
//	COLOR = vec4(texture_based_offset, 0.0, 1.0); // visualize texture-based waves
//	COLOR = vec4(sine_waves_offset, 0.0, 1.0); // visualize sine wave
}