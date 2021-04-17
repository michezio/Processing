PVector[][] VV;
float[][] damp;
Particle[] PP;

int PARTS = 1000;
float ZOOM = 0.01;
float ROT = 0.01;
float MAG = 5;
int OPAC = 10;
color BKG = color(255,255,255);
int MARGIN = 1;

int h;

void setup()
{
  colorMode(HSB);
  size(400,300);
  background(0);
  
  VV = new PVector[width][height];
  damp = new float[width][height];
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++)
    {
      float n = noise(i*ZOOM,j*ZOOM)*TWO_PI*2;
      VV[i][j] = PVector.fromAngle(n);
      VV[i][j].setMag(MAG);
      damp[i][j] = noise(i*ROT,j*ROT)*PI/180;
    }
    
  
  
  PP = new Particle[PARTS];
  for (int i=0; i<PARTS; i++)
    PP[i] = new Particle();
}

void draw()
{
  println(frameRate);
 
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++)
    {
      VV[i][j].rotate(ROT);
    }
  for (int i=0; i<PARTS; i++)
    PP[i].show(color(255,OPAC));
}