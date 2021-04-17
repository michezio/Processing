class Ball
{
  final float _SIGHT = SIGHT*SIGHT;
  final float _THRESH = THRESH*THRESH;
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
    this(random(width), random(height));
  }
  
  Ball(float x, float y)
  { 
    dim = random(SIZE/3,SIZE);
    mass = dim;
    shade = color(random(30)+hue, random(200,255), 150);
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
    if (dist < 1) dist = 1;
    
    axel.set(b.p.x - p.x, b.p.y - p.y);
    
    if (dist > _SIGHT) return;
    
    axel.normalize();
    axel.mult(FORCE*(dist-_THRESH)*(mass+b.mass)/(dist*dist));
    a.add(axel);
    //float bc = DIFFUSION * (hue(b.shade)) + 256;
    //float oc = (1 - DIFFUSION) * (hue(shade)) + 256;
    //shade = color((bc + oc) % 256, saturation(shade), brightness(shade));
  }
  
  void update()
  {
    prev.set(p.x,p.y);
    v.add(a);
    v.limit(dim*1.3);
    v.mult(1-VISC);
    p.add(v);
    
    
    
    
    if (p.x > width - dim/2) 
    {
     p.x = width - dim/2;
     v.x *= -1;
     v.y *= DAMP;
    }
    else if (p.x < dim/2)
    {
     p.x = dim/2;
     v.x *= -1;
     v.y *= DAMP;
    }
    
    if (p.y > height - dim/2) 
    {
     p.y = height - dim/2;
     v.y *= -1;
     v.x *= DAMP;
    }
    else if (p.y < dim/2)
    {
     p.y = dim/2;
     v.y *= -1;
     v.x *= DAMP;
    }
  }
}

float sqDist(PVector a, PVector b)
{
  return ((a.x-b.x)*(a.x-b.x))+((a.y-b.y)*(a.y-b.y));
}
