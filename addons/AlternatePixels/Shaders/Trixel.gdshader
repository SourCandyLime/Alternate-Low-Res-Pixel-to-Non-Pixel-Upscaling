shader_type canvas_item;
uniform sampler2D src_tex;

void fragment() {
    float sqrt3 = sqrt(3.0);
    
    vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 viewport_size = 1.0 / TEXTURE_PIXEL_SIZE;
    
    // For equilateral triangles in a grid
    // 2 triangles per unit width, height = sqrt(3)/2
    vec2 aspect = screen_size / vec2(
        ((viewport_size.x - 1.0) * 0.5),  // Each pair of triangles takes 0.5 width
        (viewport_size.y - 1.0) * sqrt3 * 0.5
    );
    
    // Pixel space in screen pixels
    vec2 px = UV * screen_size;
    px /= aspect;
    
    // Convert to triangle grid coordinates
    // For equilateral triangles, we need proper skew transformation
    vec2 t;
    t.x = px.x - px.y / sqrt3;  // Remove skew
    t.y = px.y * 2.0 / sqrt3;    // Scale to unit height
    
    // Determine row and column
    float row = floor(t.y);
    float col_pair = floor(t.x);  // Which pair of triangles (0, 1, 2...)
    
    float fx = fract(t.x);
    float fy = fract(t.y);
    
    // Determine which triangle within the pair (0 = first/left, 1 = second/right)
    float triangle_in_pair = (fx + fy < 1.0) ? 0.0 : 1.0;
    
    // Calculate actual column index (sequential triangle number in row)
    float col = col_pair * 2.0 + triangle_in_pair;
    
    vec2 tr = vec2(col, row);
    tr.x += 2.0 * floor(tr.y * 0.5) + mod(tr.y, 2.0);
    
    // Sample the texture at the triangle's position
    vec4 colr = texture(src_tex, (tr + 1.5) / viewport_size);
    
    if (colr.a < 0.1)
        discard;
        
    COLOR = colr;
}