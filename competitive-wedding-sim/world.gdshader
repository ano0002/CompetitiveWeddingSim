shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float splits = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
     COLOR = floor(texture(screen_texture, SCREEN_UV)*255.0/splits)*splits/255.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
