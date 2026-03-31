shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform int shade_amount = 50;

void fragment() {
	vec4 pixel_color = texture(screen_texture, UV);
	vec4 altered_color = ceil(pixel_color * float(shade_amount)) / float(shade_amount);
	COLOR = altered_color;
}