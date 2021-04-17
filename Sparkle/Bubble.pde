class Bubble
{  
  PVector pos;
  PVector vel;
  PVector acc;
  color shade;
  float size;
  float mass;
  float G = 20;
  
  void display()
  {
    update();
    fill(shade);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update()
  {
    vel.add(acc);
    pos.add(vel);
  }
  
  float distance(Bubble _obj)
  {
    return sqrt(((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  void accelerate(Bubble _grav)
  { 
    PVector axel = new PVector(_grav.pos.x - pos.x,
                               _grav.pos.y - pos.y);
    axel.normalize();
    float dist = distance(_grav);
    axel.mult(G*_grav.mass/(dist*dist));
    acc.add(axel);
  }
  
  boolean isTouching(Bubble _grav)
  {
    if (distance(_grav) < size/2 + _grav.size/2)
      return true;
    else return false;
  }
  
  boolean isTooFar()
  {
    if (pos.x > 3*width - width ||
        pos.x < -width ||
        pos.y > 3*height - height ||
        pos.y < -height) 
    {
      return true;
    }
    else return false;
  }
}