shader_type canvas_item;

render_mode blend_add;

uniform sampler2D textur;

float ball(float radius, vec2 position) {
	float circle = distance(position, vec2(0.5));
	return step(radius, circle);
}

void fragment() {
	vec4 texture_color = texture(textur, UV);
	float circle_width = 0.45;
	float circle = ball(circle_width, UV);
	circle = circle < 0.45 ? 1.0 : 0.0;
	vec4 color = vec4(circle,0.0,0.0, 1.0) * texture_color;
	COLOR = color;
}
