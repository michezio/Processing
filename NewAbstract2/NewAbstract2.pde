float ACC = 0.01;
float RAD = 20;
float TRANSPARENCY = 20;
float VARIANCE = 2;
float RANGE = 256;
float DAMP = 0;
int COUNT = 200;
int GEN = 1;
int HUESHIFT = 0;
float POSITION = 0.666;
float SPEED = 2;
float INIT_SPEED = 0.2;
int LIFE = 200;

int max, c;

ArrayList<Circle> circ;
Circle center;

void setup()
{
  fullScreen();
  //size(600,480);
  background(0);
  
  center = new Circle();
  circ = new ArrayList<Circle>();
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
}

void draw()
{
  center.wabble();
  if(c++%30 == 0)
    if (random(1) > 0.9) 
    {
      max = 1000;
      center.vel.setMag(SPEED/5);
    }
    else
    {
      max = 100;
      center.vel.setMag(SPEED);
    }
  if (circ.size() <= COUNT)
    for (int i=0; i<GEN; i++)
      circ.add(new Circle(center.pos,max));
  for (int i=circ.size()-1; i>=0; i--)
  {
    Circle I = circ.get(i);
    for (int j=i+1; j<circ.size(); j++)
    {
      Circle J = circ.get(j);
      float d = distance(I,J);
      float r = I.rad+J.rad;
      if (d < r*r && d > DAMP)
      {
        float m = (I.ctr+J.ctr)/VARIANCE;
        float h = 256*TRANSPARENCY/(I.ctr+J.ctr);
        stroke((HUESHIFT+m)%RANGE, 255, 255, h);
        line(I.pos.x, I.pos.y, J.pos.x, J.pos.y);
      }
    }
    if ( I.pos.y > height+2*I.rad || I.pos.y < 0-2*I.rad 
         || I.pos.x > width+2*I.rad || I.pos.x < 0-2*I.rad || I.ctr > I.maxctr)
      circ.remove(i);
    else I.update();
  } 
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}

float distance(Circle c1, Circle c2)
{
  float x = c1.pos.x-c2.pos.x;
  float y = c1.pos.y-c2.pos.y;
  return x*x+y*y;
}