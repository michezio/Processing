class Circle
{
  PVector pos;
  PVector vel;
  PVector acc;
  int ctr;
  
  Circle()
  {
    vel = new PVector(random(SPEED/10,SPEED/5), random(SPEED/10,SPEED/5));
    if (random(1)>0.5) vel.x = -vel.x;
    if (random(1)>0.5) vel.y = -vel.y;  
    acc = new PVector(0,0);
    pos = new PVector(random(width),random(height));
    ctr = 0;
  }
  
  Circle(float x, float y)
  {
    acc = new PVector(random(SPEED/1000.0,SPEED/100.0), random(SPEED/1000.0,SPEED/100.0));
    if (random(1)>0.5) acc.x = -acc.x;
    if (random(1)>0.5) acc.y = -acc.y;  
    vel = new PVector(acc.x,acc.y);
    pos = new PVector(x+random(-COMP,COMP),y+random(-COMP,COMP));
    ctr = round(random(LIFETIME/2));
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