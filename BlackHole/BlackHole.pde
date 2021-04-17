Bubble[] elements;
Bubble[] blacks;

int ballcount = 1000;
int blackholes = 3;
float G = 40;

void setup()
{
  frameRate(30);
  fullScreen();
  background(0);
  //size(640,480);
  
  elements = new Bubble[ballcount];
  blacks = new Bubble[blackholes];
  
  for (int i=0; i<blackholes; i++)
    blacks[i] = new Bubble(i, 20, 1000, color(50),
                new PVector(random(width),random(height)));
  
  for (int i=0; i<ballcount; i++)
    elements[i] = new Bubble(i);   
}

void draw()
{
  background(0);
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration = new PVector(0,0);
    for (int j=0; j<blackholes; j++)
    {
      elements[i].accelerate(blacks[j]);
      if (elements[i].isTouching(blacks[j]) || elements[i].isTooFar())
        elements[i] = new Bubble(i);
    }
    elements[i].acceleration.limit(2);
  }
  for (int i=0; i<ballcount; i++)
    elements[i].display();
  for (int j=0; j<blackholes; j++)
    blacks[j].display2();
  
  if (frameCount % 500 == 0) change();
}

void change()
{
  for (int i=0; i<blackholes; i++)
    blacks[i] = new Bubble(i, 20, 1000, color(50),
                new PVector(random(width),random(height)));
}