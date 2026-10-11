#version 320 es
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
uniform float is_active; // 1.0 if focused, 0.0 if unfocused

// --- DATA-DRIVEN CONFIGURATION DIRECTIVES ---
#define BAR_HEIGHT 48.0
#define EAR_WIDTH 64.0
#define EAR_OFFSET_X 24.0

// Catppuccin Mocha themed colors (Easily tweakable!)
#define COLOR_EAR       vec4(0.95, 0.54, 0.66, 1.0) // Pink (#f38ba8)
#define COLOR_INNER     vec4(0.96, 0.76, 0.77, 1.0) // Lighter accent (#f2cdcd)

// Helper function to calculate signed distance for triangles
float sdTriangle(vec2 p, vec2 p0, vec2 p1, vec2 p2) {
    vec2 e0 = p1 - p0, e1 = p2 - p1, e2 = p0 - p2;
    vec2 v0 = p - p0, v1 = p - p1, v2 = p - p2;
    vec2 pq0 = v0 - e0 * clamp(dot(v0, e0) / dot(e0, e0), 0.0, 1.0);
    vec2 pq1 = v1 - e1 * clamp(dot(v1, e1) / dot(e1, e1), 0.0, 1.0);
    vec2 pq2 = v2 - e2 * clamp(dot(v2, e2) / dot(e2, e2), 0.0, 1.0);
    float s = sign(e0.x * e2.y - e0.y * e2.x);
    vec2 d = min(min(vec2(dot(pq0, pq0), s * (v0.x * e0.y - v0.y * e0.x)),
                     vec2(dot(pq1, pq1), s * (v1.x * e1.y - v1.y * e1.x))),
                 vec2(dot(pq2, pq2), s * (v2.x * e2.y - v2.y * e2.x)));
    return -sqrt(d.x) * sign(d.y);
}

void main() {
    // Automatically compute window pixel dimensions from texture coordinates
    vec2 resolution = vec2(1.0) / fwidth(v_texcoord);
    vec2 p = v_texcoord * resolution;
    
    // 1. Process the 48-pixel top bar region
    if (p.y < BAR_HEIGHT) {
        // Left ear geometry (extending upwards from BAR_HEIGHT to 0.0)
        vec2 l_p0 = vec2(EAR_OFFSET_X, BAR_HEIGHT);
        vec2 l_p1 = vec2(EAR_OFFSET_X + EAR_WIDTH * 0.5, 0.0);
        vec2 l_p2 = vec2(EAR_OFFSET_X + EAR_WIDTH, BAR_HEIGHT);
        
        // Right ear geometry
        float right_start = resolution.x - EAR_OFFSET_X - EAR_WIDTH;
        vec2 r_p0 = vec2(right_start, BAR_HEIGHT);
        vec2 r_p1 = vec2(right_start + EAR_WIDTH * 0.5, 0.0);
        vec2 r_p2 = vec2(right_start + EAR_WIDTH, BAR_HEIGHT);
        
        float dLeft = sdTriangle(p, l_p0, l_p1, l_p2);
        float dRight = sdTriangle(p, r_p0, r_p1, r_p2);
        
        if (dLeft <= 0.0) {
            // Inner ear detail for left ear
            vec2 inner_l0 = vec2(EAR_OFFSET_X + EAR_WIDTH * 0.25, BAR_HEIGHT - 6.0);
            vec2 inner_l1 = vec2(EAR_OFFSET_X + EAR_WIDTH * 0.5, 10.0);
            vec2 inner_l2 = vec2(EAR_OFFSET_X + EAR_WIDTH * 0.75, BAR_HEIGHT - 6.0);
            
            if (sdTriangle(p, inner_l0, inner_l1, inner_l2) <= 0.0) {
                fragColor = COLOR_INNER;
            } else {
                fragColor = COLOR_EAR;
            }
            return;
        } 
        else if (dRight <= 0.0) {
            // Inner ear detail for right ear
            vec2 inner_r0 = vec2(right_start + EAR_WIDTH * 0.25, BAR_HEIGHT - 6.0);
            vec2 inner_r1 = vec2(right_start+ EAR_WIDTH * 0.5, 10.0);
            vec2 inner_r2 = vec2(right_start + EAR_WIDTH * 0.75, BAR_HEIGHT - 6.0);
            
            if (sdTriangle(p, inner_r0, inner_r1, inner_r2) <= 0.0) {
                fragColor = COLOR_INNER;
            } else {
                fragColor = COLOR_EAR;
            }
            return;
        }
        else {
            // Outside the ears in the top bar band -> Discard pixels (transparent cutout)
            discard;
        }
    }
    
    // 2. Main window body region (below 48px)
    vec4 texColor = texture(tex, v_texcoord);
    
    // Optional focus dimming (keeps your test functionality intact)
    texColor.rgb *= mix(0.85, 1.0, is_active);
    
    fragColor = texColor;
}
