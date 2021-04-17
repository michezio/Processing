Bubble[] elements;

int ballcount = 30;
float G = 50;

void setup()
{
  fullScreen();
  background(0);
  //size(640,480);
  elements = new Bubble[ballcount];
  for (int i=0; i<ballcount; i++)
  {
    elements[i] = new Bubble(i);
    elements[i].acceleration = new PVector(0,0);
  }  
}

void draw()
{
  background(0);
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration = new PVector(0,0);
    for (int j=0; j<ballcount; j++)
    {
      boolean status = false;
      if (j != i)
      status = accelerate(elements[i], elements[j]);
      if(status)
      {
        if (elements[i].dim < elements[j].dim)
        { 
          elements[j].dim += sqrt(elements[i].dim)/2;
          elements[i] = new Bubble(i);
        }
        else
        {
          elements[i].dim += sqrt(elements[j].dim)/2;
          elements[j] = new Bubble(j);
        }
      }
    }
    elements[i].display();
  }
}

float distance(PVector pos, PVector pos2){
  return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
}

boolean accelerate(Bubble _ball, Bubble _grav)
{
  float K = G;
  //if (_grav.number % 2 == 0)
  //K = -G;
  //else K = G;
  
  PVector axel = new PVector(_grav.position.x - _ball.position.x,
                             _grav.position.y - _ball.position.y);
  axel.normalize();
  float dist = distance(_ball.position, _grav.position);
  if (dist < _ball.dim/2 + _grav.dim/2) return true;
  _ball.acceleration.add(axel.mult(K*_grav.mass/(dist*dist)));
  _ball.acceleration.limit(0.5);
  return false;
}