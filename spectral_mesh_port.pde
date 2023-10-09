PShader myShader;

void setup() {
  size(640, 480, P3D);
  frameRate(30);
  myShader = loadShader("shader.frag", "shader.vert");
  myShader.set("invert_switch", invertValue);  // Set the initial value
  xNoiseImage = createImage(width, height, RGB);
  yNoiseImage = createImage(width, height, RGB);
  zNoiseImage = createImage(width, height, RGB);
}

void draw() {
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
  shader(myShader);
  //rect(100, 100, 600, 400);
  update();
}

void update() {
  xNoiseImage = generatePerlinNoise(xLfoArg, pLockSmoothed[4], xNoiseImage);
  yNoiseImage = generatePerlinNoise(yLfoArg, pLockSmoothed[5], yNoiseImage);
  zNoiseImage = generatePerlinNoise(zLfoArg, pLockSmoothed[3], zNoiseImage);
  myShader.set("x_noise_image", xNoiseImage);
  myShader.set("y_noise_image", yNoiseImage);
  myShader.set("z_noise_image", zNoiseImage);
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
