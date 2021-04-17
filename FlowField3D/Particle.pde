class Particle
{
  PVector pos;
  PVector vel;
  PVector[] hist;
  boolean out = false;
  int life;
  int cc;
  
  Particle()
  {
    pos = new PVector(random(width),random(height),-random(height));
    vel = new PVector(0,0,0);
    life = 0;
    hist = new PVector[LENGTH];
    for (int i=0; i<LENGTH; i++)
    {
      hist[i] = new PVector();
      hist[i] = pos.copy();
    }
    cc = 0;
  }
  
  void update(PVector[][][] array)
  {  
    for (int i=0; i<LENGTH-1; i++)
    {
      hist[i] = hist[i+1].copy();
    }
    
    boolean toUpdate = true;
    
    if (pos.x > width-MARGIN || pos.x < MARGIN) toUpdate = false;
    if (pos.y > height-MARGIN || pos.y < MARGIN) toUpdate = false;
    if (pos.z < -height+MARGIN || pos.z > -MARGIN) toUpdate = false;
    
    hist[LENGTH-1] = pos.copy();   
       
    if (toUpdate)
    {
      int indX = floor(pos.x/SCALE);
      int indY = floor(pos.y/SCALE);
      int indZ = abs(floor(pos.z/SCALE));
      vel.add(array[indX][indY][indZ]);
      vel.limit(LIMIT);
      pos.add(vel);
    }
    else cc++;
    
    if (cc == LENGTH) out = true;
    
    life++;
  }
  
  void show(PVector[][][] array, color col)
  {
    update(array);
    strokeWeight(2);
    for (int i=0; i<LENGTH-1; i++)
    {
      float h = (i*255/LENGTH);
      stroke(col,h);
      line(hist[i].x,hist[i].y,hist[i].z,hist[i+1].x,hist[i+1].y,hist[i+1].z);
    }
    stroke(col,255);
    line(hist[LENGTH-1].x,hist[LENGTH-1].y,hist[LENGTH-1].z,pos.x,pos.y,pos.z);
  }
}