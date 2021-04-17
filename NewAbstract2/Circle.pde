class Circle
{
  PVector pos;
  PVector vel;
  float rad;
  PVector acc;
  int ctr;
  int maxctr;
  
  Circle(PVector p, int max)
  {
    pos = new PVector(p.x,p.y);
    acc = new PVector(random(-ACC/3,ACC/3), -random(-ACC/3,ACC/3));
    vel = new PVector(0,0);
    vel.add(acc);
    vel.setMag(INIT_SPEED);
    maxctr = round(random(max));
    ctr = round(maxctr/3);
    rad = random(RAD/5,RAD);
    if (max == 1000) rad*=2;
  }
  
  Circle()
  {
    pos = new PVector(0,height/2);
    vel = new PVector(SPEED,0);
    acc = new PVector(0,0);
    rad = 0;
    ctr = 0;
  }
  
  void update()
  {
    ctr++;
    vel.add(acc);
    pos.add(vel);
  }
  
  void wabble()
  {
    vel.rotate(random(-PI/32,PI/32));
    pos.add(vel);
    if (pos.x < 0)
      pos.x = width;
    if (pos.x > width)
      pos.x = 0;
    if (pos.y < 0)
      pos.y = height;
    if (pos.y > height)
      pos.y = 0;
  }
}