class Bouncer
{
  PVector pos;
  float velx, vely;
  color shade;
  float size;
  
  Bouncer(float _size, color _shade, float x, float y, PVector _vel)
  {
    size = _size;
    shade = _shade;
    pos = new PVector(x,y);
    velx = _vel.x;
    vely = _vel.y;
  }
  
  void display()
  {
    updatepos();
    fill(shade);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void updatepos()
  {
    pos.x += velx;
    pos.y += vely;
    
    if (pos.x > width - size/2)
      {
        velx = -velx;
        pos.x = width - size/2;
      }
    if (pos.x < size/2)
      {
        velx = -velx;
        pos.x = size/2;
      }
    if (pos.y > height - size/2)
      {
        vely = -vely;
        pos.y = height - size/2;
      }
    if (pos.y < size/2)
      {
        vely = -vely;
        pos.y = size/2;
      }
  }
}