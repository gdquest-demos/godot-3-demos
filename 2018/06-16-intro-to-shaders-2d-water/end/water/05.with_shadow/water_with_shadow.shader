shader_type canvas_item;

uniform vec4 shadow_color : hint_color;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform sampler2D texture_offset_uv : hint_black;
uniform vec2 texture_offset_scale = vec2(0.2, 0.2);
uniform float texture_offset_height = 0.1;

uniform float texture_offset_time_scale = 0.05;

uniform float sine_time_scale = 0.03;
uniform vec2 sine_offset_scale = vec2(0.4, 0.4);
uniform float sine_wave_size = 0.4;


void fragment() {
	vec2 base_uv_offset = UV * texture_offset_scale;
	base_uv_offset += TIME * texture_offset_time_scale;

	vec2 offset_texture_uv = texture(texture_offset_uv, base_uv_offset).rg;
	vec2 offset_texture_uv_with_height = offset_texture_uv * texture_offset_height;
	vec2 texture_based_offset = offset_texture_uv_with_height * 2.0 - 1.0;

	vec2 adjusted_uv = UV * tile_factor;
	adjusted_uv.y *= aspect_ratio;
	adjusted_uv += texture_based_offset;

	adjusted_uv.x += sin(TIME * sine_time_scale + (adjusted_uv.x + adjusted_uv.y) * sine_offset_scale.x) * sine_wave_size;
	adjusted_uv.y += cos(TIME * sine_time_scale + (adjusted_uv.x + adjusted_uv.y) * sine_offset_scale.y) * sine_wave_size;

	float sine_wave_height = sin(TIME * sine_time_scale + (adjusted_uv.x + adjusted_uv.y) * sine_offset_scale.y);
	float water_height = ( sine_wave_height + offset_texture_uv.g ) * 0.5;

//	COLOR = vec4(vec2(offset_texture_uv), 0.0, 1.0);
	COLOR = mix(texture(TEXTURE, adjusted_uv), shadow_color, water_height * 0.4);
//	COLOR = vec4(vec2(adjusted_uv), 0.0, 1.0);
	NORMALMAP = texture(NORMAL_TEXTURE, adjusted_uv / 5.0).rgb;
//	COLOR = texture(NORMAL_TEXTURE, adjusted_uv / 5.0);
}
