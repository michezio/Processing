PVector[][][] flowField;

int cols;
int rows;
int lays;
Particle[] particles;

int c;

void setup()
{
  frameRate(1000);
  size(600,600,P3D);
  background(BKGND);
  hint(ENABLE_STROKE_PERSPECTIVE);
  colorMode(HSB);
  
  rows = width/SCALE;
  cols = height/SCALE;
  lays = height/SCALE;
  
  noiseSeed(floor(random(100)));
  flowField = new PVector[rows][cols][lays];
  for (int i=0; i<rows; i++)
  {
    for (int j=0; j<cols; j++)
    {
      for (int k=0; k<lays; k++)
      {
        float x = noise(i*COMP, j*COMP, k*COMP)*2-1;
        float y = noise(i*COMP+1000, j*COMP+1000, k*COMP+1000)*2-1;
        float z = noise(i*COMP+2000, j*COMP+2000, k*COMP+2000)*2-1;
        flowField[i][j][k] = new PVector(x,y,z);
        flowField[i][j][k].mult(MAG);
      }
    }
  }
  
  particles = new Particle[PARTCOUNT];
  for (int i=0; i<PARTCOUNT; i++)
    particles[i] = new Particle();
}

void draw()
{
  camera(mouseX*2-width, mouseY*2-height, (height/2), width/2, height/2, -height/2, 0, 1, 0);
  println(frameRate);
  clear();
  lights();
  
  //for (int i=0; i<100; i++)
  //  flowField[floor(random(rows))][floor(random(cols))][floor(random(lays))] = new PVector(random(-MAG,MAG),random(-MAG,MAG),random(-MAG,MAG));
  
  for (int i=0; i<PARTCOUNT; i++)
  {
    if (!particles[i].out && particles[i].life < LIFETIME) particles[i].show(flowField,color(i*255/PARTCOUNT,255,255));
    else particles[i] = new Particle();
  }
}