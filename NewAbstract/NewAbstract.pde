float ACC = 0.005;
float RAD = 20;
float TRANSPARENCY = 2;
float VARIANCE = 2;
float RANGE = 255;
boolean REFLECTION = false;
float OPACITY = 25;
float DAMP = 2;
int COUNT = 50;
int HUESHIFT = -20;
float POSITION = 0.666;
boolean FLAME = false;
float SPEED = 1;
int LIFE = 200;


PImage reflection, shade;

Circle[] circ;
Circle center;

void setup()
{
  fullScreen();
  //size(600,480);
  background(0);
  
  if (!FLAME) REFLECTION = false;
  
  center = new Circle();
  circ = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle(center.pos);
  }
  
  if (REFLECTION)
  {
    reflection = createImage(width,round((1-POSITION)*height),HSB);
    shade = createImage(width,round((1-POSITION)*height),HSB);
    for (int i=0; i<shade.height; i++)
    {
      float h = map(i,0,shade.height,0,1);
      for (int j=0; j<shade.width; j++)
        shade.set(j,i,color(0,OPACITY+((255-OPACITY)*atan(DAMP*h)/atan(DAMP))));
    }
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
}

void draw()
{
  center.wabble();
  for (int i=0; i<COUNT; i++)
  {
    for (int j=i+1; j<COUNT; j++)
    {
      float d = distance(circ[i],circ[j]);
      float r = circ[i].rad+circ[j].rad;
      if (d < r*r)
      {
        float m = (circ[i].ctr+circ[j].ctr)/VARIANCE;
        float h = 256*TRANSPARENCY/(circ[i].ctr+circ[j].ctr);
        stroke((HUESHIFT+m)%RANGE, 255, 255, h);
        line(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y);
      }
    }
    if ( circ[i].pos.y > height+2*circ[i].rad || circ[i].pos.y < 0-2*circ[i].rad 
         || circ[i].pos.x > width+2*circ[i].rad || circ[i].pos.x < 0-2*circ[i].rad || circ[i].ctr > LIFE)
      circ[i] = new Circle(center.pos);
    else circ[i].update();
  } 
}

void mouseClicked()
{
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle();
  }
}

void keyPressed()
{
  if (key == 's')
  {
    if (REFLECTION)
    {
      reflection = get(0,0,width,round(POSITION*height));
      pushMatrix();
      scale(1.0, -(1-POSITION)/POSITION);
      image(reflection,0,-POSITION*height-reflection.height*(POSITION/(1-POSITION)));
      popMatrix();
      image(shade,0,POSITION*height);
    }
    saveFrame();
  }
}

float distance(Circle c1, Circle c2)
{
  float x = c1.pos.x-c2.pos.x;
  float y = c1.pos.y-c2.pos.y;
  return x*x+y*y;
}