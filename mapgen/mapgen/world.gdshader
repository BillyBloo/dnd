shader_type canvas_item;

uniform float islandness = 1.0;
uniform sampler2D land_noise;
uniform float land_height = 0.5;

void fragment() {
	float land_sample = texture(land_noise,UV).r;
	land_sample -= pow(length(vec2(UV - vec2(0.5,0.5)))*2.,1.8)*islandness;
	if (land_sample < land_height) COLOR.a = 0.;
	else COLOR.rgb = vec3(1.,1.,1.);
}