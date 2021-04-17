Bubble[] elements;

int ballcount = 100;
float vert = 0.8;
float hori = 0;

void setup()
{
  frameRate(30);
  smooth(8);
  fullScreen();
  background(0);
  //size(640,480);
  elements = new Bubble[ballcount];
  for (int i=0; i<ballcount; i++)
  {
    elements[i] = new Bubble();
    elements[i].acceleration.y = vert;
    elements[i].acceleration.x = hori;
  }
  
}

void draw()
{
  background(0);
  for (int i=0; i<ballcount; i++)
  {
    elements[i].display();
  }
}

void mouseClicked()
{
  vert = random(2)-1;
  hori = random(2)-1;
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration.y = vert;
    elements[i].acceleration.x = hori;
  }
}