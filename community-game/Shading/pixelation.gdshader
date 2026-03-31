shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

uniform int pixel_size = 4;

void fragment() {
	int center_pixel_coords = ((pixel_size - 1) / 2) + 1;
	
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);
	
	x = float(center_pixel_coords - int(x));
	y = float(center_pixel_coords - int(y));
	
	COLOR = texture(SCREEN_TEXTURE, (FRAGCOORD.xy + vec2(x,y)) / (1.0 / SCREEN_PIXEL_SIZE.xy));
}