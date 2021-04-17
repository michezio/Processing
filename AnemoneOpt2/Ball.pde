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
  
  Ball(float x, float y)
  { 
    dim = SIZE/2;
    mass = dim;
    shade = color(random(30)+hue, random(200,255), 255);
    p = new PVector(x,y);
    prev = p.copy();
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
  
  void displayLine()
  {
    strokeWeight(2*dim);
    stroke(shade);
    line(p.x, p.y, prev.x, prev.y);
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
    prev.set(p.x,p.y);
    a.add(PVector.mult(v,-VISC));
    v.add(a);
    v.add(grav);
    p.add(v);
    
    if (p.x > width - dim/2) 
    {
     p.x = width - dim/2;
     v.x *= -DAMP;
     v.y *= DAMP;
    }
    else if (p.x < dim/2)
    {
     p.x = dim/2;
     v.x *= -DAMP;
     v.y *= DAMP;
    }
    
    if (p.y > height - dim/2) 
    {
     p.y = height - dim/2;
     v.x *= DAMP;
     v.y *= -DAMP;
    }
    else if (p.y < dim/2)
    {
     p.y = dim/2;
     v.x *= DAMP;
     v.y *= -DAMP;
    }
  }
}

float sqDist(PVector a, PVector b)
{
  return ((a.x-b.x)*(a.x-b.x))+((a.y-b.y)*(a.y-b.y));
}