uniform sampler2D tex0;
varying vec2 texCoordVarying;

uniform float luma_key_level;
uniform float invert_switch;
uniform float b_w_switch;
uniform int luma_switch;

void main() {
    // vec4 color = texture2D(tex0, texCoordVarying);
    vec4 color = vec4(1.0, 0.0, 0.0, 1.0); // Directly set the color to red
    float bright = 0.33 * color.r + 0.5 * color.g + 0.16 * color.b;

    // Grayscale effect
    color = b_w_switch * vec4(bright) + (1.0 - b_w_switch) * color;

    // Inversion effect
    color.rgb = invert_switch * (1.0 - color.rgb) + (1.0 - invert_switch) * color.rgb;

    // Luma keying
    if (luma_switch == 0 && bright < luma_key_level) {
        color.w = 0.0;
    }
    if (luma_switch == 1 && bright > luma_key_level) {
        color.w = 0.0;
    }

    gl_FragColor = color;
}
