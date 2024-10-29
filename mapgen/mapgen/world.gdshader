shader_type canvas_item;

uniform sampler2D land_noise;

void fragment() {
	float land_sample = texture(land_noise,UV).r;
	COLOR = vec4(land_sample,land_sample,land_sample,1.);
}