final int COUNT = 1000;
final float FORCE = 10;
final float DAMP = 1.2;
final float VISC = 0.1;
int THRESH = 20;
final int SIZE = 10;
int SIGHT = 500;

final float EXTENSION = 0.2;
float ext;

ArrayList<Ball> b;

int hue;

PVector grav;

void setup()
{
  SIGHT *= SIGHT;
  THRESH *= THRESH;

  colorMode(HSB);

  //fullScreen();
  size(400,400);
  b = new ArrayList<Ball>();
  background(0);
}

void draw()
{
  thread("updateBalls");
  //background(0);
  PVector ppp = new PVector(0,0);
  loadPixels();
  for (int x=0; x<width; ++x)
  {
    for (int y=0; y<height; ++y)
    {
      float d = 0;
      for (int i=0; i<b.size(); ++i)
      {
        ppp.set(x,y);
        d += b.get(i).dim / sqDist(ppp, b.get(i).p);
      }
      pixels[x+y*width] = color((d>EXTENSION)?0:255);
    }
  }
  updatePixels();
}

void mouseDragged()
{
  b.add(new Ball(mouseX+random(-10,10), mouseY+random(-10,10)));
  if (b.size() > COUNT)
    b.remove(0);
    
  if (b.size() < COUNT)
    ext = sqrt(b.size());
  else ext = sqrt(COUNT);
}

void updateBalls()
{
  for (Ball B : b) B.stop();
  for (int i=0; i<b.size(); ++i)
  { 
    for (int j=0; j<b.size(); ++j)
    {
      if (i == j) continue;
      b.get(i).interact(b.get(j));
    }
    b.get(i).update();
  }
}