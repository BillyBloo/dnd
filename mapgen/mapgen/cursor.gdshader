shader_type canvas_item;

uniform float size = 128.0;

void fragment() {
	COLOR.rgb = vec3(1.);
	float a = pow(length(UV-vec2(0.5,0.5))*2.,size / 6.4);
	if (a > 1.) a = 0.;
	COLOR.a = a;
}