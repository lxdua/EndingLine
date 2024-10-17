shader_type canvas_item;

uniform float value: hint_range(0.0, 1.0) = 0.2;

void fragment() {
	COLOR.a *= smoothstep(0.0, value, 1.0 - UV.y);
}