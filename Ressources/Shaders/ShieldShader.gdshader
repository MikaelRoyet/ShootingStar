shader_type canvas_item;

uniform float alpha = 1.0;

void vertex() {
	VERTEX += vec2(cos(TIME * 10.0)*100.0, sin(TIME * 10.0)*100.0) * vec2(2,2);
}

void fragment() {
	COLOR.a = alpha;
}
