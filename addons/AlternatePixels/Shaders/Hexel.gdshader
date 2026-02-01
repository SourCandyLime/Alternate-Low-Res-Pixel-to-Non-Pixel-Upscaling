shader_type canvas_item;

uniform sampler2D src_tex;

// axial hex rounding
vec2 hex_round(vec2 h) {
    vec3 cube = vec3(h.x,  h.y, -h.x - h.y);
    vec3 rc = round(cube);
    vec3 diff = abs(rc - cube);

    if (diff.x > diff.y && diff.x > diff.z)
        rc.x = -rc.y - rc.z;
    else if (diff.y > diff.z)
        rc.y = -rc.x - rc.z;
	else
		rc.z = -rc.x - rc.y;

    return vec2(rc.x, rc.y);
}

void fragment() {
	float sqrt3 = sqrt(3);
	
	vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 viewport_size = 1.0 / TEXTURE_PIXEL_SIZE;
	
	vec2 aspect = screen_size / vec2(
    	(viewport_size.x - 1.0) * 1.5,
    	(viewport_size.y - 1.0) * sqrt3
	);

	
    // --- Pixel space in screen pixels
    vec2 px = UV * screen_size;
	px /= aspect;

    // --- Convert screen pixels to axial coordinates (flat-top)
    vec2 h;
    h.x = ((2.0 / 3.0) * px.x);
    h.y = ((-1.0 / 3.0) * px.x) + (sqrt3 / 3.0) * px.y;

    vec2 hr = hex_round(h);
	
	hr.y += floor(hr.x / 2.0);

    vec4 colr = texture(src_tex, (hr + 0.5) / viewport_size);

    if (colr.a < 0.1)
        discard;

    COLOR = colr;
}
