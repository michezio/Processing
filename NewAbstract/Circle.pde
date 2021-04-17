class Circle
{
  PVector pos;
  PVector vel;
  float rad;
  PVector acc;
  int ctr;
  
  Circle(PVector p)
  {
    pos = new PVector(p.x,p.y);
    acc = new PVector(random(-ACC/3,ACC/3), -random(ACC/10,ACC));
    vel = new PVector(0,0);
    if (!FLAME && !REFLECTION)
      if (random(1)>0.5) acc.y = -acc.y;
    rad = random(RAD/5,RAD);
    ctr = floor(random(100));
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