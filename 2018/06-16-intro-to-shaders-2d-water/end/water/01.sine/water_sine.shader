shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform vec2 time_factor = vec2(2.0, 3.0);
uniform vec2 offset_factor = vec2(5.0, 2.0);
uniform vec2 amplitude = vec2(0.05, 0.05);

void fragment() {
	vec2 tiled_uvs = UV * tile_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 wave_uv_offset;
	wave_uv_offset.x += sin(TIME * time_factor.x + (tiled_uvs.x + tiled_uvs.y) * offset_factor.x);
	wave_uv_offset.y += cos(TIME * time_factor.y + (tiled_uvs.x + tiled_uvs.y) * offset_factor.y);
	
//	COLOR = texture(TEXTURE, tiled_uvs);
	COLOR = texture(TEXTURE, tiled_uvs + wave_uv_offset * amplitude);
//	COLOR = vec4(wave_uv_offset, vec2(0.0, 1.0));
//	COLOR = vec4(UV * aspect_ratio, vec2(0.0, 1.0));
}