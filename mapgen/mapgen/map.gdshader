shader_type canvas_item;

uniform sampler2D noise;
uniform sampler2D draw;

uniform vec4 land_col : source_color;

void fragment() {
	vec4 noise_sample = texture(noise,UV);
	COLOR = vec4(noise_sample.rgb,texture(draw,UV).a * noise_sample.r);
	if (COLOR.a > 0.1) COLOR = land_col;
	else COLOR.a = 0.;
}
