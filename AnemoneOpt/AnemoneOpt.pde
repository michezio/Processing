final int COUNT = 1000;
final float FORCE = 10;
final float DAMP = 1;
final float VISC = 0.2;
final int THRESH = 2500;
final int SIZE = 8;
final int SIGHT = 200;
ArrayList<Ball> b;

int hue;

PVector grav;

void setup()
{
  colorMode(HSB);

  //fullScreen();
  size(600,600);
  b = new ArrayList<Ball>();
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