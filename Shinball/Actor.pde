class Actor
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  boolean active = false;
  
  
  Actor(float x, float y)                // CREATE ACTOR AT GIVEN POSITION
  {
    size = ASIZE;
    pos = new PVector(x, y);
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
    if (active)
    {
      acc.x = (mouseX - startX);
      acc.y = (mouseY - startY);
      acc.normalize();
      acc.mult(ACCMAX);

      vel.add(acc);
    }
    else acc.x = acc.y = 0;
    
    vel.mult(DAMP);
    pos.add(vel);
    
    if (pos.x < size/2) { pos.x = size/2; vel.x = -vel.x*BDAMP; }
    if (pos.x > width-size/2) { pos.x = width-size/2; vel.x = -vel.x*BDAMP; }
    if (pos.y < size/2) { pos.y = size/2; vel.y = -vel.y*BDAMP; }
    if (pos.y > height-size/2) { pos.y = height-size/2; vel.y = -vel.y*BDAMP; }
  }
  
  float distance(Enemy _obj)
  {
    return (((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  boolean isTouching(Enemy _obj)
  {
    if (distance(_obj) < (size/2+_obj.size/2)*(size/2+_obj.size/2))
      return true;
    else return false;
  }

}