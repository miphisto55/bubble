shader_type canvas_item;

render_mode blend_mix;

uniform sampler2D textur;
uniform vec4 colour;

// colours:
// Orange - vec4(0.94, 0.52, 0.27, 1.0)
// Yellow - vec4(0.97, 0.81, 0.31, 1.0)
// Green - vec4(0.44, 0.97, 0.31, 1.0)
// Sky Blue - vec4(0.31, 0.87, 0.97, 1.0)
// Deep Blue - vec4(0.23, 0.27, 0.80, 1.0)
// Deep Purple - vec4(0.53, 0.22, 0.76, 1.0)
// Pink - vec4(0.89, 0.43, 0.90, 1.0)
// Red - vec4(0.91, 0.33, 0.33, 1.0)

float ball(float radius, vec2 position) {
	float circle = distance(position, vec2(0.5));
	return step(radius, circle);
}

void fragment() {
	vec4 texture_color = texture(textur, UV);
	float circle_width = 0.45;
	float circle = ball(circle_width, UV);
	circle = circle < 0.45 ? 1.0 : 0.0;
	vec4 color = vec4(colour.r, colour.g,colour.b, 1.0) * texture_color * circle;
	COLOR = color;
}
