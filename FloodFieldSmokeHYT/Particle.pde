class Particle
{
  PVector pos;
  PVector prev;
  PVector org;
  int life;
  int lifespan;
  
  Particle(PVector poss)
  {
    org = poss.copy();
    pos = new PVector(org.x + random(-XSPAN,XSPAN), org.y);
    lifespan = round(random(MAXLIFE));
  }
  
  void update()
  {      
    if (pos.x > width-MARGIN || pos.x < MARGIN ||
        pos.y > height-MARGIN || pos.y < MARGIN ||
        life > lifespan)
    {
      pos.x = org.x + random(-XSPAN,XSPAN);
      pos.y = org.y;
      life = 0;
      lifespan = round(random(MAXLIFE));
    }
    
    prev = pos.copy();
    
    pos.add(VV[floor(pos.x)][floor(pos.y)]);
    
    life++;
  }
  
  void show(color h)
  {
    update();
    stroke(h);
    strokeCap(SQUARE);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  
}