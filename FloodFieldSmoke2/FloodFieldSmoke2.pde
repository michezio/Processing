Particle[] PP;

int PARTS = 1000;
int MAXLIFE = 200;
float ZOOM = 0.008;
float MUT = 0.05;
float LIM = 2;
float MAG = 5;
color BKG = color(0);
color COL = color(255,0,0,10);
int MARGIN = 2;

int h;

void setup()
{
  frameRate(1000);
  colorMode(HSB);
  size(400,400);
  background(BKG);
    
  PP = new Particle[PARTS];
  
  for (int i=0; i<PARTS; i++)
    PP[i] = new Particle();
}

void draw()
{
  println(frameRate);
  
  if (frameCount % 60 == 0) 
  {
    fill(0,5);
    rect(0,0,width,height);
  }
  
  for (int i=0; i<PARTS; i++)
  {
    PP[i].update(frameCount);
    PP[i].show();
  }
}