shader_type canvas_item;

uniform sampler2D noise;
uniform sampler2D draw;

uniform vec4 land_col : source_color;
uniform sampler2D land_grad;

uniform int blur_samples_width = 7;
uniform vec2 res = vec2(1000,1000);
uniform float blur_sample_spacing = 1.0;

void fragment() {
	float brightness = 0.;
	float total_weight = 0.;
	for (int i = -(blur_samples_width/2); i <= (blur_samples_width/2); i++){
		for (int j = -(blur_samples_width/2); j <= (blur_samples_width/2); j++){
			vec2 diff = vec2(float(i), float(j)) * (blur_sample_spacing / res);
			float weight = pow(10000.0,-(diff.x*diff.x + diff.y*diff.y));
			total_weight += weight;
			brightness += texture(draw,UV + diff).r * weight;
		}
	}
	brightness *= 1.0 / total_weight;
	vec4 noise_sample = texture(noise,UV);
	COLOR = vec4(noise_sample.rgb, brightness);
	if (COLOR.r * COLOR.a > 0.49) COLOR = land_col;
	else COLOR.a = 0.;
}
