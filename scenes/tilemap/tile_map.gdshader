shader_type canvas_item;

uniform float intensity = 1.0;

void fragment() 
{
	float grayscale = (COLOR.r + COLOR.g + COLOR.b) / 3.0 * intensity;
	COLOR = vec4(grayscale, grayscale, grayscale, COLOR.a);
}
