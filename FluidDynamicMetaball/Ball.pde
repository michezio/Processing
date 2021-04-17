class Ball
{
  float dim;
  float mass;
  color shade;
  PVector p;
  PVector v;
  PVector a;
  PVector axel;
  
  Ball(float x, float y)
  { 
    dim = SIZE/2;
    mass = dim;
    shade = color(random(30)+hue, random(200,255), 255);
    p = new PVector(x,y);
    v = new PVector(0,0);
    a = new PVector(0,0);
    axel = new PVector(0,0);
  }
  
  void display()
  {
    noStroke();
    fill(shade);
    ellipse(p.x, p.y, 2*dim, 2*dim);
    //fill(255);
    //text(number, position.x, position.y);
  }
  
  void stop()
  {
    a.mult(0);
  }
  
  void interact(Ball b)
  { 
    float dist = sqDist(this.p,b.p);
    if (dist < SIZE*SIZE) dist = SIZE*SIZE;
    
    axel.set(b.p.x - p.x, b.p.y - p.y);
    
    if (dist > SIGHT) return;
    
    axel.normalize();
    
    axel.mult(FORCE*(dist-THRESH)*(mass+b.mass)/(dist*dist));
    a.add(axel);
    
  }
  
  void update()
  {
    v.add(a);
    v.mult(1-VISC);
    p.add(v);
    
    if (p.x > width - dim/2) 
    {
     p.x = width - dim/2;
     v.x *= -DAMP;
    }
    else if (p.x < dim/2)
    {
     p.x = dim/2;
     v.x *= -DAMP;
    }
    
    if (p.y > height - dim/2) 
    {
     p.y = height - dim/2;
     v.y *= -DAMP;
    }
    else if (p.y < dim/2)
    {
     p.y = dim/2;
     v.y *= -DAMP;
    }
  }
}

float sqDist(PVector a, PVector b)
{
  return ((a.x-b.x)*(a.x-b.x))+((a.y-b.y)*(a.y-b.y));
}