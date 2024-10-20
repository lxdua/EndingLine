shader_type canvas_item;

uniform vec4 fog_color : source_color;

void fragment() {
	COLOR.rgb = fog_color.rgb;
	COLOR.a = texture(TEXTURE,UV).r;
}
