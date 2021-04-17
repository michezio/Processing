float MOMENTUM = 0.25;
float MAX_SPEED = 50;
float DAMP = 0.985;

class Actor
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size = 20;
  
  Actor()
  {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void display()
  {
    update();
    fill(color(ACT,255,255));
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update()
  {
    if (left) acc.x = -MOMENTUM;
    else if (right) acc.x = MOMENTUM;
    else acc.x = 0;
    if (up) acc.y = -MOMENTUM;
    else if (down) acc.y = MOMENTUM;
    else acc.y = 0;
    
    vel.add(acc);
    vel.mult(DAMP);
    pos.add(vel);
    
    if (pos.x < size/2) { pos.x = size/2; vel.x = 0; }
    if (pos.x > width-size/2) { pos.x = width-size/2; vel.x = 0; }
    if (pos.y < size/2) { pos.y = size/2; vel.y = 0; }
    if (pos.y > height-size/2) { pos.y = height-size/2; vel.y = 0; }
  }
  
  float distance(Enemy _obj)
  {
    return sqrt(((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  boolean isTouching(Enemy _obj)
  {
    if (distance(_obj) < size/2 + _obj.size/2)
      return true;
    else return false;
  }

}