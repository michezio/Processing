Bubble[] elements;
Bubble[] blacks;

int ballcount = 300;
int blackholes = 5;
float G = 50;
float topmass = 10000;

void setup()
{
  frameRate(30);
  fullScreen();
  
  //size(640,480);
  background(255);
  
  elements = new Bubble[ballcount];
  blacks = new Bubble[blackholes];
  
  for (int i=0; i<blackholes; i++)
    blacks[i] = new Bubble(i, 4, 500, color(240),
                new PVector(random(width),random(height)));
  
  for (int i=0; i<ballcount; i++)
    elements[i] = new Bubble(i);   
}

void draw()
{
  background(255);
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration = new PVector(0,0);
    for (int j=0; j<blackholes; j++)
    {
      elements[i].accelerate(blacks[j]);
      if (elements[i].isTouching(blacks[j]))
      {
        blacks[j].mass+=elements[i].mass;
        if (blacks[j].mass > topmass)
          blacks[j] = new Bubble(i, 4, 500, color(240), new PVector(random(width),random(height)));
      }
      if (elements[i].isTouching(blacks[j]) || elements[i].isTooFar())
        elements[i] = new Bubble(i); 
    }
    elements[i].acceleration.limit(1.5);
  }
  for (int i=0; i<ballcount; i++)
    elements[i].display();
  for (int j=0; j<blackholes; j++)
  {
    blacks[j].shade = color(255 - blacks[j].mass/topmass*255);
    blacks[j].display();
  }
}