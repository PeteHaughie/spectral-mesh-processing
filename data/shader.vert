uniform mat4 transform;
uniform sampler2D tex0;
uniform sampler2D x_noise_image;
uniform sampler2D y_noise_image;
uniform sampler2D z_noise_image;

varying vec2 texCoordVarying;

uniform vec2 xy;
uniform int bright_switch;
uniform float x_lfo;
uniform float x_lfo_arg;
uniform float x_lfo_amp;
uniform float y_lfo_arg;
uniform float y_lfo_amp;
uniform float z_lfo_arg;
uniform float z_lfo_amp;
uniform float x_lfo_other;
uniform float y_lfo_other;
uniform float z_lfo_other;

uniform vec2 xy_offset;

uniform int yLfoShape;
uniform int xLfoShape;
uniform int zLfoShape;

uniform int y_phasemod_switch;
uniform int z_phasemod_switch;
uniform int x_phasemod_switch;

uniform int y_ringmod_switch;
uniform int z_ringmod_switch;
uniform int x_ringmod_switch;

uniform int width;
uniform int height;

attribute vec4 vertex;
attribute vec2 texCoord;

float oscillate(float theta, int shape, int xyz) {
    float osc = 0.0;
    
    if (shape == 0) { osc = sin(theta); }
    if (shape == 1) { osc = sign(sin(theta)); }
    if (shape == 2) { osc = fract(theta / 6.18); }
    if (shape == 3) {
        if (xyz == 0) { osc = 2.0 * (texture2D(x_noise_image, texCoord * 0.5).r - 0.5); }
        if (xyz == 1) { osc = 2.0 * (texture2D(y_noise_image, texCoord * 0.5).r - 0.5); }
        if (xyz == 2) { osc = 2.0 * (texture2D(z_noise_image, texCoord * 0.5).r - 0.5); }
    }
    return osc;
}

void main() {
    texCoordVarying = texCoord;
    vec4 new_position = transform * vertex;
    vec4 color = texture2D(tex0, texCoordVarying);
    float bright = 0.33 * color.r + 0.5 * color.g + 0.16 * color.b;

    bright = 2.0 * log(1.0 + bright);
    
    if (bright_switch == 1) {
        bright = 1.0 - bright;
    }

    new_position.x = new_position.x + xy_offset.x;
    new_position.y = new_position.y + xy_offset.y;

    float x_lfo_val = x_lfo_amp * oscillate(x_lfo_arg + new_position.y * x_lfo_other, xLfoShape, 0);
    float y_lfo_val = (y_lfo_amp + float(y_ringmod_switch) * 0.01 * x_lfo_val) * oscillate(y_lfo_arg + new_position.x * y_lfo_other + float(y_phasemod_switch) * 0.01 * x_lfo_val, yLfoShape, 1);

    float z_lfo_amp_dummy = z_lfo_amp + float(z_ringmod_switch) * 0.0025 * y_lfo_val;
    float z_lfo_frequency = z_lfo_arg + z_lfo_other * distance(abs(new_position.xy), vec2(xy_offset.x / 2.0, xy_offset.y / 2.0) + float(z_phasemod_switch) * y_lfo_val);
    float z_lfo_val = z_lfo_amp_dummy * oscillate(z_lfo_frequency, zLfoShape, 2);

    new_position.xy = new_position.xy * (1.0 - z_lfo_val);

    float x_lfo_amp_dummy = x_lfo_amp + float(x_ringmod_switch) * 1000.0 * z_lfo_val;
    float x_lfo_frequency = x_lfo_arg + new_position.y * x_lfo_other + float(x_phasemod_switch) * 10.0 * z_lfo_val;
    x_lfo_val = x_lfo_amp_dummy * oscillate(x_lfo_frequency, xLfoShape, 0);

    new_position.x = new_position.x + xy.x * bright + x_lfo_val;

    float y_lfo_amp_dummy = y_lfo_amp + float(y_ringmod_switch) * x_lfo_val;
    float y_lfo_frequency = y_lfo_arg + new_position.x * y_lfo_other + float(y_phasemod_switch) * 0.01 * x_lfo_val;
    y_lfo_val = y_lfo_amp_dummy * oscillate(y_lfo_frequency, yLfoShape, 1);

    new_position.y = new_position.y + xy.y * bright + y_lfo_val;

    new_position.x = new_position.x - xy_offset.x;
    new_position.y = new_position.y - xy_offset.y;

    gl_Position = new_position;
}
