class Particle
{
  PVector pos;
  PVector prev;
  boolean out = false;
  color shade;
  int life;
  
  Particle(color shad)
  {
    shade = shad;
    pos = new PVector(random(width),random(height));
    life = 0;
  }
  
  void update(PVector[][] array)
  {  
    prev = pos.copy();
    
    if (pos.x > width-MARGIN || pos.x < MARGIN) out = true;
    if (pos.y > height-MARGIN || pos.y < MARGIN) out = true;
    
    int indX = floor(pos.x/SCALE);
    int indY = floor(pos.y/SCALE);
    
    if (!out) pos.add(array[indX][indY]);
    
    life++;
  }
  
  void show(PVector[][] array)
  {
    update(array);
    stroke(shade,OPACITY);
    line(prev.x,prev.y,pos.x,pos.y);
  }
}