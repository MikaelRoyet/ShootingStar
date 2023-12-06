shader_type canvas_item;



uniform float removed_segments:hint_range(-0.1, 1.) = 1.;
uniform vec4 ring_color = vec4(1);
uniform vec4 bg_color = vec4(0,0,0,0);
uniform vec4 bg_line_color = vec4(0.5,0.5,0.5,1);
uniform vec4 empty_cell_color = vec4(0.25,0.25,0.25,0);
uniform bool antialias = false;
uniform float pixelFactor : hint_range(0,1) = .25;
uniform float radius :hint_range(0, 1) = 0.7;
uniform float line_width :hint_range(0, 1) = 0.21;
uniform float bg_width :hint_range(0, 1) = 0.28;


mat2 tex_rotate(float _angle){
	return mat2(vec2(cos(_angle), -sin(_angle)), vec2(sin(_angle), cos(_angle)));
}

void fragment(){
	vec2 uv;
	if(pixelFactor != 0.){
		vec2 pixelNumber = vec2(textureSize(TEXTURE, 0)) * pixelFactor;
		vec2 pixelated_UV = round(UV * pixelNumber) / pixelNumber;
		uv = (pixelated_UV * 2.0 - 1.0);
	}else{
		uv = (UV * 2.0 - 1.0);
	}
	
	float angle = atan(uv.x, uv.y) + PI;
	float segment = abs(sin(angle + PI * 2.)) * length(uv);
	angle -= removed_segments * 2. * PI;
	float circle = length(uv) - radius;
	float ring = abs(circle) - line_width;
	float background = abs(circle) - bg_width;
	
	if(antialias){
		ring /= fwidth(circle);
		angle /= fwidth(angle);
		segment /= fwidth(segment);
		background /= fwidth(background);
	}else{
		ring = ceil(ring);
		angle = ceil(angle);
		segment = ceil(segment);
		background = ceil(background);
	}
	ring = 1. - ring;
	segment = 1. - segment;
	background = 1. - background;
	
	ring = clamp(ring,0,1);
	angle = clamp(angle,0,1);
	segment = clamp(segment,0,1);
	background = clamp(background,0,1);
	float base_ring = ring;
	
	ring -= angle;
	ring = clamp(ring,0,1);
	
	if(ring > 0.){
		COLOR = ring_color;
		COLOR.a = ring;
	}else{
		if(segment >= 1. && base_ring >= 1.){
			COLOR = bg_line_color;

		}
		COLOR.a = background;
	}
}