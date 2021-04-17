class Circle
{
  PVector pos;
  PVector vel;
  float rad;
  PVector acc;
  int ctr;
  
  Circle()
  {
    pos = new PVector(random(width+2*RAD)-RAD,3*height/4);
    acc = new PVector(random(-ACC/3,ACC/3), -random(ACC/10,ACC));
    vel = new PVector(0,0);
    rad = random(RAD/5,RAD);
    ctr = floor(random(RANGE));
  }
  
  void update()
  {
    ctr++;
    vel.add(acc);
    pos.add(vel);
  }
}

float distance(Circle c1, Circle c2)
{
  float x = c1.pos.x-c2.pos.x;
  float y = c1.pos.y-c2.pos.y;
  return x*x+y*y;
}