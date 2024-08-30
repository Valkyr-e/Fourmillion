shader_type canvas_item;

uniform vec3 default_color: source_color;
uniform vec3 mid_color : source_color;
uniform vec3 outline_color: source_color;

uniform float progress: hint_range(0.0, 1.0);

uniform float shadow_south_size = 3;
uniform float shadow_south_mid_size = 2;

uniform float shadow_west_size = 1;
uniform float shadow_west_mid_size = 1;
void fragment() {
	vec4 line_neg_mid_y = vec4(mid_color.rgb, texture(TEXTURE, vec2(UV.x, UV.y - shadow_south_mid_size * TEXTURE_PIXEL_SIZE.y)).a);
	vec4 line_pos_mid_y = vec4(mid_color.rgb, texture(TEXTURE, vec2(UV.x, UV.y + TEXTURE_PIXEL_SIZE.y)).a);
	vec4 line_neg_mid_x = vec4(mid_color.rgb, texture(TEXTURE, vec2(UV.x -  TEXTURE_PIXEL_SIZE.x, UV.y)).a);
	vec4 line_pos_mid_x = vec4(mid_color.rgb, texture(TEXTURE, vec2(UV.x + shadow_west_mid_size*TEXTURE_PIXEL_SIZE.x, UV.y)).a);
	vec4 outline_mid_y = mix(line_neg_mid_y, line_pos_mid_y, line_pos_mid_y);
	vec4 outline_mid_x = mix(line_neg_mid_x, line_pos_mid_x, line_pos_mid_x);
	vec4 outline_mid = mix(outline_mid_y, outline_mid_x, outline_mid_x);
	COLOR.rgba = mix(COLOR, outline_mid, 1.0- COLOR.a);
	if(COLOR.a < 0.1) {
		vec4 line_neg_y = vec4(outline_color.rgb, texture(TEXTURE, vec2(UV.x, UV.y - (shadow_south_size )* TEXTURE_PIXEL_SIZE.x)).a);
		vec4 line_pos_y = vec4(outline_color.rgb, texture(TEXTURE, vec2(UV.x, UV.y + TEXTURE_PIXEL_SIZE.y)).a);
		vec4 line_neg_x = vec4(outline_color.rgb, texture(TEXTURE, vec2(UV.x -  TEXTURE_PIXEL_SIZE.x, UV.y)).a);
		vec4 line_pos_x = vec4(outline_color.rgb, texture(TEXTURE, vec2(UV.x + (shadow_west_size + shadow_west_mid_size)*TEXTURE_PIXEL_SIZE.y, UV.y)).a);
		vec4 outline_y = mix(line_neg_y, line_pos_y, line_pos_y);
		vec4 outline_x = mix(line_neg_x, line_pos_x, line_pos_x);
		vec4 outline = mix(outline_y, outline_x, outline_x);
		COLOR.rgba = outline;
		if(COLOR.a < 0.1) {
			COLOR = vec4(default_color,1.0);
		}
	}
}