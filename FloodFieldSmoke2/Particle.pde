class Particle
{
  PVector pos;
  PVector prev;
  PVector vel;
  int life;
  int lifespan;
  
  Particle()
  {
    pos = new PVector(random(width),random(height));
    vel = new PVector(0,0);
    lifespan = round(random(MAXLIFE));
  }
  
  void update(int i)
  {      
    if (pos.x > width-MARGIN || pos.x < MARGIN ||
        pos.y > height-MARGIN || pos.y < MARGIN ||
        life > lifespan)
    {
      pos.set(random(width),random(height));
      vel.set(0,0);
      life = 0;
      lifespan = round(random(MAXLIFE));
    }
    
    prev = pos.copy();
    
    PVector acc = new PVector(noise(i*ZOOM*MUT, pos.x*ZOOM, pos.y*ZOOM)*2-1,
                              noise(i*ZOOM*MUT, pos.x*ZOOM+1000, pos.y*ZOOM+1000)*2-1);                       
    //vel.add(acc.mult(MAG));
    //vel.limit(LIM);
    //pos.add(vel);
    
    acc.mult(MAG);
    pos.add(acc);
    
    life++;
  }
  
  void show()
  {
    stroke(COL);
    strokeCap(SQUARE);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  
}