float ACC = 0.007;
float RAD = 70;
float TRANSPARENCY = 50;
float VARIANCE = 20;
float RANGE = 50;
boolean REFLECTION = true;
float OPACITY = 10;
float DAMP = 2;
int COUNT = 50;
int HUESHIFT = -20;


PImage reflection, shade;
boolean reflectionCompleted = false, reflectionDrawn = true;

Circle[] circ;

void setup()
{
  //fullScreen();
  size(600,480);
  background(0);
  
  circ = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle();
  }
  
 
  reflection = createImage(width,height/4,HSB);
  shade = createImage(width,height/4,HSB);
  for (int i=0; i<shade.height; i++)
  {
    float h = map(i,0,shade.height,0,1);
    for (int j=0; j<shade.width; j++)
      shade.set(j,i,color(0,OPACITY+((255-OPACITY)*atan(DAMP*h)/atan(DAMP))));
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
}

void draw()
{  
  thread("generateReflection");
  
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
    if ( circ[i].pos.y < 0-2*circ[i].rad )
      circ[i] = new Circle();
    else circ[i].update();
  }
  
  if (reflectionCompleted)
  {
    image(reflection,0,3*height/4);
    image(shade,0,3*height/4);
    reflectionCompleted = false;
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
    generateReflection();
    image(reflection,0,3*height/4);
    image(shade,0,3*height/4);
    saveFrame();
  }
}