class Circle
{
  PVector pos;
  PVector vel;
  PVector acc;
  int ctr;
  
  Circle()
  {
    acc = new PVector(random(-1,1), random(-1,1), random(-1,1));
    acc.normalize();
    acc.mult(random(SPEED/100,SPEED));
    vel = new PVector(0,0,0);
    float par = min(width,height);
    pos = new PVector(random(-1,1), random(-1,1), random(-1,1));
    pos.normalize().mult(random(par/COMP));
    ctr = 0;
  }
  
  void update()
  {
    ctr++;
    vel.add(acc);
    vel.limit(SPEEDLIMIT);
    pos.add(vel);
  }
}

float distance(Circle c1, Circle c2)
{
  float x = c1.pos.x-c2.pos.x;
  float y = c1.pos.y-c2.pos.y;
  float z = c1.pos.z-c2.pos.z;
  return x*x+y*y+z*z;
}