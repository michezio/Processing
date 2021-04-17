final int COUNT = 1000;
final float FORCE = 1;
final float DAMP = 0.8;
final float VISC = 0.1;
int THRESH = 50;
final int SIZE = 10;
int SIGHT = 500;
final float GRAVITY = 0.1;
ArrayList<Ball> b;

int hue;

PVector grav;

void setup()
{
  
  SIGHT *= SIGHT;
  THRESH *= THRESH;

  colorMode(HSB);

  //fullScreen();
  size(1300,600);
  b = new ArrayList<Ball>();
  grav = new PVector(0,GRAVITY);
  background(0);
}

void draw()
{
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  for (Ball B : b) B.stop();
  for (int i=0; i<b.size(); ++i)
  { 
    for (int j=0; j<b.size(); ++j)
    {
      if (i == j) continue;
      b.get(i).interact(b.get(j));
    }
    b.get(i).update();
    b.get(i).displayLine();
  }
}

void mouseDragged()
{
  b.add(new Ball(mouseX+random(-10,10), mouseY+random(-10,10)));
  if (b.size() > COUNT)
    b.remove(0);
}

void mouseReleased()
{
  hue = floor(random(256));
}