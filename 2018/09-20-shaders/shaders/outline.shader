shader_type canvas_item;
render_mode unshaded;

uniform float width : hint_range(0.0, 0.1);
uniform vec4 outline_color : hint_color;

void fragment()
{
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -8.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -width)).a;
	alpha += texture(TEXTURE, UV + vec2(width, -width)).a;
	alpha += texture(TEXTURE, UV + vec2(width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(width, width)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, width)).a;
	alpha += texture(TEXTURE, UV + vec2(-width, width)).a;
	alpha += texture(TEXTURE, UV + vec2(-width, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-width, -width)).a;
	
	vec4 final_color = mix(sprite_color, outline_color, smoothstep(0.0, 1.0, alpha));
	COLOR = vec4(final_color.rgb, max(alpha, sprite_color.a));
}
