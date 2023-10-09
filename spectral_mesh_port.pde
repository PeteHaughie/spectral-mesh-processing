import processing.video.*;
Capture cam;

PShader shaderDisplace;

PShape mesh1;
PShape vbo_mesh1;

void setup() {
  size(640, 480, P3D);
  //fullScreen(P3D);
  frameRate(60);
  cam = new Capture(this, width, height);
  cam.start();  
  // vertical sync may or may not be needed in Processing 4
  PJOGL pgl = (PJOGL)beginPGL();
  pgl.gl.setSwapInterval(1);
  endPGL();
  //noStroke(); // don't turn this on during debugging
  shaderDisplace = loadShader("shader.frag", "shader.vert");
  shaderDisplace.set("invert_switch", invertValue);  // Set the initial value
  allocateFbo();
  trianglemesh(scale);
  xNoiseImage = createImage(width, height, RGB);
  yNoiseImage = createImage(width, height, RGB);
  zNoiseImage = createImage(width, height, RGB);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  // update values
  float cZFrequency = 0.03;
  float cXFrequency = 0.015;
  float cYFrequency = 0.02;
  
  float dLumaKeyLevel = pLockSmoothed[0] + 1.01 * az;
  float dX = 100.0 * (pLockSmoothed[1] + qw);
  float dY = 100.0 * (pLockSmoothed[2] + er);
  float dZFrequency = cZFrequency * pLockSmoothed[3] + sx;
  float dXFrequency = cXFrequency * pLockSmoothed[4] + gb;
  float dYFrequency = cYFrequency * pLockSmoothed[5] + kk;
  float dZoom = pLockSmoothed[6] * 480 + op;
  float dScale = ( 1.0 - pLockSmoothed[7] ) * 126.0 + 1.0 + scaleKey;

  float dZLfoArg = pLockSmoothed[10] + dc;
  float dXLfoArg = pLockSmoothed[12] + hn;
  float dYLfoArg = pLockSmoothed[14] + ll;
  float dCenterX =- 960.0f*pLockSmoothed[8] + ty;
  float dCenterY =- 960.0f*pLockSmoothed[9] + ui;
  float dZLfoAmp =.25*pLockSmoothed[11] + fv;   
  float dXLfoAmp = width * 0.25 * pLockSmoothed[13] + jm;   
  float dYLfoAmp = height * 0.25 * pLockSmoothed[15] + yLfoAmp;
  
  /**oscillator biz**/
  zLfoArg += dZLfoArg;
  xLfoArg += dXLfoArg;
  yLfoArg += dYLfoArg;
  
  background(255);
  
  // Set shader uniforms
  shaderDisplace.set("luma_key_level", dLumaKeyLevel);
  shaderDisplace.set("xy", dX, dY);
  shaderDisplace.set("z_lfo_amp", dZLfoAmp);
  shaderDisplace.set("z_lfo_arg", zLfoArg);
  shaderDisplace.set("z_lfo_other", dZFrequency);
  
  // Generate Perlin noise images
  xNoiseImage = generatePerlinNoise(xLfoArg, pLockSmoothed[4], xNoiseImage);
  yNoiseImage = generatePerlinNoise(yLfoArg, pLockSmoothed[5], yNoiseImage);
  zNoiseImage = generatePerlinNoise(zLfoArg, pLockSmoothed[3], zNoiseImage);
  
  // Set textures for the shader
  shaderDisplace.set("x_noise_image", xNoiseImage);
  shaderDisplace.set("y_noise_image", yNoiseImage);
  shaderDisplace.set("z_noise_image", zNoiseImage);

  // Draw the mesh with the shader
  shader(shaderDisplace);
  shape(mesh1);
  
  resetShader();
}

PGraphics aspectFixFbo;
PGraphics fbo0;

void allocateFbo() {
  aspectFixFbo = createGraphics(width, height);
  aspectFixFbo.beginDraw();
  aspectFixFbo.background(0, 255);  // Clear with black color and full opacity
  aspectFixFbo.endDraw();

  fbo0 = createGraphics(width, height);
  fbo0.beginDraw();
  fbo0.background(0, 255);  // Clear with black color and full opacity
  fbo0.endDraw();
}

// generate perlin noise images
PImage generatePerlinNoise(float theta, float resolution, PImage noiseImage) {
  noiseImage.loadPixels();  // Load the pixels for manipulation
  resolution *= 0.05;
  theta *= 0.1;
  for (int y = 0; y < noiseImage.height; y++) {
    for (int x = 0; x < noiseImage.width; x++) {
      float noiseValue = noise(x * resolution, y * resolution, theta);
      noiseImage.pixels[y * noiseImage.width + x] = color(255 * noiseValue);
    }
  }
  noiseImage.updatePixels();  // Apply the changes
  return noiseImage;
}
