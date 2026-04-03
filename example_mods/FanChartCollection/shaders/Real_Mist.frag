#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor

// === ADJUSTABLE PARAMETERS ===
#define MIST_OPACITY 0.3      // Mist transparency (0.0 = fully transparent, 1.0 = fully opaque)
#define MIST_SCALE 5.0        // Size of mist patterns (higher = smaller, more detailed mist)
#define MIST_SPEED 0.15       // Mist movement speed
#define MIST_ANGLE 200.0       // Mist movement angle in degrees
#define SWIRL_INTENSITY 0.05  // Strength of the swirling effect
#define DARKEN_FACTOR 0.5     // Darkening factor for the scene (1.0 = no darkening, lower = darker)

// Basic hash for pseudo-randomness
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Basic noise function based on the hash
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Fractal Brownian Motion (fbm) to layer multiple octaves of noise
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    for (int i = 0; i < 5; i++) {
        value += noise(p) * amplitude;
        p *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

void main()
{
    // Sample the original texture.
    vec4 inputColor = texture(iChannel0, uv);
    
    // Calculate directional offset from the adjustable mist angle.
    // Convert angle from degrees to radians.
    vec2 mistDirection = vec2(cos(radians(MIST_ANGLE)), sin(radians(MIST_ANGLE)));
    vec2 mistOffset = mistDirection * iTime * MIST_SPEED;
    
    // Generate base noise coordinates for realistic texture using fbm.
    vec2 noiseCoord = uv * MIST_SCALE + mistOffset;
    float n1 = fbm(noiseCoord);
    
    // Apply swirling distortion for added realism.
    vec2 swirl = vec2(sin(iTime + uv.y * 10.0), cos(iTime + uv.x * 10.0)) * SWIRL_INTENSITY;
    vec2 uvSwirled = uv + swirl;
    float n2 = fbm(uvSwirled * MIST_SCALE + mistOffset);
    
    // Combine the noise layers and remap to create soft transitions.
    float combinedMist = mix(n1, n2, 0.5);
    combinedMist = smoothstep(0.3, 0.7, combinedMist);
    
    // Define the mist color.
    vec3 mistColor = vec3(1.0, 1.0, 1.0);
    
    // Darken the base scene.
    vec3 baseColor = inputColor.rgb * DARKEN_FACTOR;
    
    // Blend the mist over the darkened scene using the adjustable opacity.
    float mistOpacity = combinedMist * MIST_OPACITY;
    vec3 finalColor = mix(baseColor, mistColor, mistOpacity);
    
    // Output the final pixel color.
    fragColor = vec4(finalColor, inputColor.a);
}
