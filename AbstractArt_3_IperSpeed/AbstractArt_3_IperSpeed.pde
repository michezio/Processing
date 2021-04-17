float SPEED = 2;
float OFFSET = 0;
float EXPANSION = 5000;
float CURVATURE = 1;
float HUESHIFT = 0.5;
float ECHO = 150;
float OPACITY = 5;
float COHERENCE = 2/HUESHIFT;
int COUNT = 200;
int DENSITY = 90;

float hue;
float SIZE;

Circle[] circ;
Circle center;

void setup()
{
  //fullScreen(P2D);
  size(500,500,P2D);
  background(0);
  
  
  center = new Circle(width/2,height/2);
  center.acc.set(0,0);
  
  circ = new Circle[COUNT];
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle(center.pos.x,center.pos.y);
    circ[i].ctr = -DENSITY-1;
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(1);
  
  SIZE = 1.5*max(width/2,height/2);
  SIZE *= SIZE;
  
  hue = DENSITY;
}

void draw()
{
  //noStroke();
  //fill(0,255-ECHO);
  //rect(0,0,width,height);
  
  for (int i=0; i<COUNT; i++)
  {
    float far = distance(circ[i],center);
    for (int j=i+1; j<COUNT; j++)
    {
      if (circ[i].ctr > -DENSITY) break;
      if (circ[j].ctr > -DENSITY) continue;
      float d = distance(circ[i],circ[j]);
      if (d < max(circ[i].rad,circ[j].rad))
      {
        float m = (circ[i].ctr+circ[j].ctr)/COHERENCE;
        stroke((hue+m)%256, 255, 255, OPACITY);
        line(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y);
      }
    }
    if ( far > SIZE )
    {
      circ[i] = new Circle(center.pos.x,center.pos.y);
    }
    else
    {
      circ[i].update();
      float h = map(far,0,SIZE,0.01,1);
      circ[i].setRadius(OFFSET + EXPANSION*atan(h*CURVATURE)/atan(CURVATURE));
    }
  }
  
  hue += HUESHIFT;
  saveFrame();
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}