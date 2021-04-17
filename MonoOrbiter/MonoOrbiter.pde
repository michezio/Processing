Bubble[] elements;
Bubble[] blacks;

int ballcount = 40;
int blackholes = 5;
float G = 1;
float top = 10;

void setup()
{
  fullScreen();
  
  //size(640,480);
  background(0);
  
  elements = new Bubble[ballcount];
  blacks = new Bubble[blackholes];
  
  for (int i=0; i<blackholes; i++)
    blacks[i] = new Bubble(1, 20, 500, color(0,255,0),
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
      if (elements[i].isTouching(blacks[j]))
      {
        blacks[j].number++;
        if (blacks[j].number > top)
          blacks[j] = new Bubble(1, 20, 500, color(0,255,0), new PVector(random(width),random(height)));
      }
      if (elements[i].isTouching(blacks[j]) || elements[i].isTooFar())
        elements[i] = new Bubble(i); 
    }
    //elements[i].acceleration.limit(1.5);
  }
  for (int i=0; i<ballcount; i++)
    elements[i].display();
  for (int j=0; j<blackholes; j++)
  {
    int k = blacks[j].number;
    blacks[j].shade = color(k*255/top, 255 - k*255/top, 0);
    blacks[j].display();
  }
}