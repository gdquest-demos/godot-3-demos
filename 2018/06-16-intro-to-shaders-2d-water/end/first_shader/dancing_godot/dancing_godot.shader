shader_type canvas_item;

uniform float time_factor = 2;
uniform vec2 amplitude = vec2(10, 10);

void vertex() {
	VERTEX.x += sin(TIME * time_factor) * amplitude.x;
	VERTEX.y += cos(TIME * time_factor) * amplitude.y;
}