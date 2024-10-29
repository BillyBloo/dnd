shader_type canvas_item;

void fragment() {
	COLOR = vec4(1.,1.,1.,0.05*pow(1.-length(UV-vec2(0.5,0.5))*2.,.5));
}