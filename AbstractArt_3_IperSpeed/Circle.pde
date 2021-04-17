class Circle
{
  PVector pos;
  PVector vel;
  PVector acc;
  float rad;
  int ctr;
  
  Circle(float x, float y)
  {
    acc = new PVector(random(SPEED)/1000,0);
    acc.rotate(random(-PI,PI));  
    vel = new PVector(0,0);
    pos = new PVector(x,y);
    ctr = 0;
    rad = 0;
  }
  
  void update()
  {
    ctr--;
    vel.add(acc);
    pos.add(vel);
  }
  
  void setRadius(float r)
  {
    rad = r;
  }
}

float distance(Circle c1, Circle c2)
{
  float x = c1.pos.x-c2.pos.x;
  float y = c1.pos.y-c2.pos.y;
  return x*x+y*y;
}