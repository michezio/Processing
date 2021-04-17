class Circle
{
  PVector pos;
  PVector vel;
  PVector acc;
  int ctr;
  
  Circle(float COMP)
  {
    acc = new PVector(random(SPEED/1000.0,SPEED/100.0), 0);
    acc.rotate(random(TWO_PI));  
    vel = new PVector(0,0);
    float par = min(width,height);
    do
      pos = new PVector(width/2+random(-par/COMP,par/COMP),height/2+random(-par/COMP,par/COMP));
    while(dist(pos.x,pos.y,width/2,height/2)>par/COMP);
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