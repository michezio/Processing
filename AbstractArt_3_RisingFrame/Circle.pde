class Circle
{
  PVector pos;
  PVector vel;
  PVector acc;
  int ctr;
  
  Circle()
  {
    acc = new PVector(0, -random(SPEED/1000.0,SPEED/100.0));
    vel = new PVector(0,0);
    pos = new PVector(random(width + 40) - 20,height + 10);
    ctr = 0;
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
