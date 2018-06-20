shader_type canvas_item;

uniform float tile_factor = 10.0;
uniform float aspect_ratio = 0.5;

uniform sampler2D uv_offset_texture : hint_black;
uniform vec2 uv_offset_scale = vec2(0.2, 0.2);
uniform float wave_size = 0.1;

uniform vec2 time_scale = vec2(0.05, 0.08);

void fragment() {
	vec2 base_uv_offset = UV * uv_offset_scale; // Determine the UV that we use to look up our DuDv
	base_uv_offset += TIME * time_scale; // pan or scroll the texture over time
	
	vec2 texture_based_offset = texture(uv_offset_texture, base_uv_offset).rg; // Get our offset
	texture_based_offset = texture_based_offset * 2.0 - 1.0; // Convert from 0.0 <=> 1.0 to -1.0 <=> 1.0
	texture_based_offset *= wave_size; // And apply our amplitude
	
	vec2 adjusted_uv = UV * tile_factor; // Scale the UVs to get a tiled texture
	adjusted_uv.y *= aspect_ratio; // Apply aspect ratio
	
	COLOR = texture(TEXTURE, adjusted_uv + texture_based_offset); // And lookup our color
}