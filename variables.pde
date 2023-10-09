float invertValue = 0.0;  // Default value

float rescale = 1;

float theta = 0;

float xLfo = 0;
float xLfoArg = 0;
float yLfo = 0;
float yLfoArg = 0;
float zLfo = 0;
float zLfoArg = 0;

boolean wireframeSwitch = false;
boolean brightSwitch = false;

boolean invertSwitch = false;
boolean strokeWeightSwitch = false;

int scale = 100;

int scaleKey = 0;

int yLfoShape = 0;
int xLfoShape = 0;
int zLfoShape = 0;

boolean yFreq0 = false;
boolean yRingmodSwitch = false;
boolean yPhasemodSwitch = false;

boolean xFreq0 = false;
boolean xRingmodSwitch = false;
boolean xPhasemodSwitch = false;

boolean zFreq0 = false;
boolean zRingmodSwitch = false;
boolean zPhasemodSwitch = false;

float globalXDisplace = 0.0;
float globalYDisplace = 0.0;

float centerXDisplace = 0.0;
float rotateX = 0.0;
float rotateCapture_z = 0.0;

boolean rotateCaptureZSwitch = true;
boolean rotateXSwitch = true;
boolean globalXDisplaceSwitch = true;
boolean centerXDisplaceSwitch = false;

float centerYDisplace = 0.0;
float rotateY = 0.0;

boolean rotateYSwitch = false;
boolean globalYDisplaceSwitch = false;
boolean centerYDisplaceSwitch = false;
boolean lumaSwitch = false;

boolean BWSwitch = false;

float stroke_weight = 1;

// mesh types
// 0 is trianglegrid
// 1 is horizontal lines
// 2 is vertical lines
int meshType = 0;

PImage xNoiseImage, yNoiseImage, zNoiseImage;

// p_lock
final int P_LOCK_SIZE = 240;
boolean pLockRecordSwitch = false;
boolean pLockErase = false;
// maximum number of p_locks available...maybe there can be one for every knob
// for whatever wacky reason the last member of this array of arrays has a glitch
// so I guess just make an extra array and forget about it for now
final int P_LOCK_NUMBER = 17;
// so how we will organize the p_locks is in multidimensional arrays
// to access the data at timestep x for p_lock 2 (remember counting from 0) we use p_lock[2][x]
float[][] pLock = new float[P_LOCK_NUMBER][P_LOCK_SIZE];
// smoothing parameters(i think for all of these we can array both the arrays and the floats
// for now let us just try 1 smoothing parameter for everything.
float pLockSmooth = .5;
// and then lets try an array of floats for storing the smoothed values
float[] pLockSmoothed = new float[P_LOCK_NUMBER];
// turn on and off writing to the array
boolean pLock0Switch = true;
// global counter for all the locks
int pLockIncrement = 0;

// key value defaults
float ss = 1;
float dd = 1;
float gg = 1;
float hh = 0;
float ee = 1;
float pp = 1;
float ii = 0.01;
float az = 0.0;
float sx = 0.0;
float dc = 0.0;
float fv = 0.0;
float gb = 0.0;
float hn = 0.0;
float jm = 0.0;
float kk = 0.0;
float ll = 0.0;
float yLfoAmp = 0.0;
float ty = 0.0;
float qw = 0;
float er = 0;
float ui = 0;
float op = 0;
