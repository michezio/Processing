class Particle
{
  PVector pos;
  PVector prev;
  
  Particle()
  {
    pos = new PVector(random(width),random(height));
  }
  
  void update()
  {
    prev = pos.copy();
    
    pos.add(VV[floor(pos.x)][floor(pos.y)]);
    
    if (pos.x > width-MARGIN || pos.x < MARGIN || pos.y > height-MARGIN || pos.y < MARGIN)
    {
      pos.x = random(width);
      pos.y = random(height);
      prev = pos.copy();
    }
  }
  
  void show(color h)
  {
    update();
    stroke(h);
    strokeCap(SQUARE);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  
}