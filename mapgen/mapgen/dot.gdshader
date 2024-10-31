shader_type canvas_item;

uniform float a_mult = 1.0;

void fragment() {
	COLOR = vec4(a_mult,a_mult,a_mult,pow(1.-length(UV-vec2(0.5,0.5))*2.,0.01));
}