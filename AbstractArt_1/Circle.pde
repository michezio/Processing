class Circle
{
  PVector pos;
  PVector vel;
  float rad;
  PVector acc;
  int ctr;
  
  Circle()
  {
    pos = new PVector(random(width+2*RMAX)-RMAX,height/2);
    acc = new PVector(random(-MAX/2,MAX/2), random(MIN,MAX));
    vel = new PVector(0,0);
    if (random(1)>0.5) acc.y = -acc.y;
    rad = random(RMIN,RMAX);
    ctr = 0;
  }
  
  void update()
  {
    ctr++;
    vel.add(acc);
    pos.add(vel);
  }
}