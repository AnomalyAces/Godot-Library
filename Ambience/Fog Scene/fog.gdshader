shader_type canvas_item;

//Noise texture
uniform sampler2D noise_texture: repeat_enable, filter_nearest;

//Fog Density
uniform float density: hint_range(0.0, 1.0) = 0.25;

//Fog Speed
uniform vec2 speed = vec2(0.02, 0.01);


void fragment() {
	//Make Fog Slowly Move
	vec2 uv = UV + speed * TIME;
	//Sample The Noise Texture
	float noise = texture(noise_texture, uv).r;
	//Convert the noise from the (0.0, 1.0) range to the (-1.0, 1.0) range
	// and clamp it between 0.0 and 1.0 again
	float fog = clamp(noise * 2.0 - 1.0, 0.0, 1.0);
	//Apply Fog Effect
	COLOR.a *= fog * density;
}