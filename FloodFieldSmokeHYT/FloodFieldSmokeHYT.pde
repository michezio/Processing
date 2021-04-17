PVector[][] VV;
ArrayList<Particle> PP;

int PARTS = 1000;
int MAXLIFE = 200;
float ZOOM = 0.1;
float ROT = 0.05;
float MAG = 2;
color BKG = color(255);
color COL = color(255,0,0,10);
int MARGIN = 2;
int XSPAN = 0;

PVector ORIGIN;

int h;

void setup()
{
  frameRate(1000);
  colorMode(HSB);
  size(400,400);
  background(BKG);
  
  VV = new PVector[width][height];
  
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++)
    {
      float n = (noise(i*ZOOM,j*ZOOM)*2-1)-PI/2;
      VV[i][j] = PVector.fromAngle(n);
      VV[i][j].setMag(MAG);
    }
    
  ORIGIN = new PVector(width/2, 4*height/5);
  PP = new ArrayList<Particle>();
}

void draw()
{
  println(frameRate);
  //noStroke();
  //fill(BKG);
  //rect(0,0,width,height);
 
  float var = random(-ROT,ROT);
  
  for (int i=0; i<width; i++)
    for (int j=0; j<height; j++)
    {
      VV[i][j].rotate(var);
    }
  
  if (PP.size() < PARTS) PP.add(new Particle(ORIGIN));
  
  for (int i=0; i<PP.size(); i++)
    PP.get(i).show(color(COL));
}