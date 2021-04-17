class Ball
{
  float dim;
  float mass;
  color shade;
  PVector p;
  PVector prev;
  PVector v;
  PVector a;
  PVector axel;
  
  Ball()
  { 
    dim = SIZE/2;//random(SIZE/5,SIZE);
    mass = dim;
    shade = color(random(0,30), random(200,255), 255);
    p = new PVector(random(width),random(height));
    prev = p.copy();
    v = new PVector(0,0);
    a = new PVector(0,0);
    axel = new PVector(0,0);
  }
  
  void display()
  {
    strokeWeight(2*dim);
    stroke(shade);
    line(p.x, p.y, prev.x, prev.y);
    //fill(255);
    //text(number, position.x, position.y);
  }
  
  void stop()
  {
    a.mult(0);
  }
  
  void repell(Ball b)
  { 
    float dist = sqDist(this.p,b.p);
    
    if (dist > 10000) return;
    else
    {
      axel.set(p.x - b.p.x, p.y - b.p.y);  
      //if (dist < pow(dim+b.dim,2))
      //{
      //  float d = axel.mag();
      //  PVector mtd = axel.copy();
      //  mtd.mult((dim+b.dim-d)/d);
      //  p.add(mtd);
      //}
      axel.normalize();
      axel.mult(FORCE*(mass+b.mass)/dist);
      a.add(axel);
    }
  }
  
  void springForce(Ball c, float s)
  {
    PVector axel = new PVector(c.p.x - p.x, c.p.y - p.y);
    float dist = sqDist(this.p,c.p);
    axel.normalize();
    axel.mult(dist/(s*s));
    a.add(axel);
  }
  
  void mouseForce(Ball c, float s)
  {
    float dist = sqDist(this.p,c.p);
    if (dist > SENSE*SENSE) return;
    else
    {
      PVector axel = new PVector(p.x - c.p.x, p.y - c.p.y);
      axel.normalize();
      axel.mult(s/(dist));
      a.add(axel);
    }
  }
  
  void update()
  {
    prev.set(p.x,p.y);
    PVector visc = v.copy();
    visc.mult(-VISC);
    a.add(visc);
    a.limit(1);
    v.add(a);
    v.mult(DAMP);
    p.add(v);
    
    //if (p.x > width - dim/2) 
    //{
    //  p.x = width - dim/2;
    //  v.x *= 0;
    //}
    //else if (p.x < dim/2)
    //{
    //  p.x = dim/2;
    //  v.x *= 0;
    //}
    
    //if (p.y > height - dim/2) 
    //{
    //  p.y = height - dim/2;
    //  v.y *= 0;
    //}
    //else if (p.y < dim/2)
    //{
    //  p.y = dim/2;
    //  v.y *= 0;
    //}
  }
}

float sqDist(PVector a, PVector b)
{
  return ((a.x-b.x)*(a.x-b.x))+((a.y-b.y)*(a.y-b.y));
}