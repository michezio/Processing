class Particle
{
  PVector pos;
  PVector vel;
  float size;
  
  Particle(PVector p, PVector v)
  {
    pos = new PVector(p.x,p.y);
    vel = new PVector(v.x,v.y);
    size = random(PSIZE/10,PSIZE);
  }
  
  void show(int i)
  {
    pos.add(vel);
    if (pos.x < size/2) { pos.x = size/2; vel.x = -vel.x*BDAMP; }
    if (pos.x > width-size/2) { pos.x = width-size/2; vel.x = -vel.x*BDAMP; }
    if (pos.y < size/2) { pos.y = size/2; vel.y = -vel.y*BDAMP; }
    if (pos.y > height-size/2) { pos.y = height-size/2; vel.y = -vel.y*BDAMP; }
    noStroke();
    fill(ENM,100,255,i);
    ellipse(pos.x,pos.y,size,size);
  }
}

class Collision
{
  Particle[] parts;
  int tim;
  PVector pos;
  
  Collision(PVector p, PVector v)
  {
    pos = new PVector(p.x,p.y);
    PVector vel = v.copy();
    vel.rotate(PI/2);
    
    parts = new Particle[CDENSE];
    for (int i=0; i<CDENSE; i++)
    {
      if (random(1) > 0.5)
        parts[i] = new Particle(pos,vel.rotate(random(-PI/8,PI/8)).normalize().mult(random(PSPEED/5,PSPEED*2)));
      else
        parts[i] = new Particle(pos,vel.rotate(PI + random(-PI/8,PI/8)).normalize().mult(random(PSPEED/5,PSPEED*2)));
    }
    tim = PRESENCE;
  }
  
  void show()
  {
    float d = CWAVE*(PRESENCE-tim)/PRESENCE;
    noStroke();
    fill(ENM,255,255,tim/5.0);
    ellipse(pos.x,pos.y,ESIZE+d,ESIZE+d);
    for (int i=0; i<CDENSE; i++)
      parts[i].show(tim);
    tim--;
  }
}