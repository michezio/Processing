class Circle
{
  PVector pos;
  PVector vel;
  float rad;
  PVector acc;
  int ctr;
  
  Circle()
  {
    pos = new PVector(random(width+2*RAD)-RAD,round(POSITION*height));
    acc = new PVector(random(-ACC/3,ACC/3), -random(ACC/10,ACC));
    vel = new PVector(0,0);
    if (!FLAME && !REFLECTION)
      if (random(1)>0.5) acc.y = -acc.y;
    rad = random(RAD/5,RAD);
    ctr = floor(random(100));
  }
  
  void update()
  {
    ctr++;
    vel.add(acc);
    pos.add(vel);
  }
}