float MIN = 0.01;
float MAX = 0.1;
float RMIN = 10;
float RMAX = 50;
int BIAS = 0;

int COUNT = 100;

Circle[] circ;

void setup()
{
  fullScreen();
  //size(600,480);
  background(0);
  
  circ = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle();
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
  
  BIAS = floor(random(256));
}

void draw()
{
  for (int i=0; i<COUNT; i++)
  {
    circ[i].update();
    for (int j=i+1; j<COUNT; j++)
    {
      if (dist(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y) < circ[i].rad+circ[j].rad)
      {
        float m = (circ[i].ctr+circ[j].ctr)/3;
        stroke((BIAS+m)%256, 255, 255, 20);
        line(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y);
      }
    }
    if ( circ[i].pos.y > height+2*circ[i].rad || circ[i].pos.y < 0-2*circ[i].rad )
      circ[i] = new Circle();
  }
}

void mouseClicked()
{
  BIAS = floor(random(256));
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}