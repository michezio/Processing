float MOMENTUM = 0.1;
float MAX_SPEED = 5;
float DAMP = 0.998;
float SIZE = 10;

class Actor
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  color shade;
  
  Actor()
  {
    shade = color(0,50);
    size = SIZE;
    pos = new PVector(width/2, height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void display()
  {
    fill(shade);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update()
  {
    if (left) acc.x = -MOMENTUM;
    else if (right) acc.x = MOMENTUM;
    else acc.x = 0;
    if (up) acc.y = -MOMENTUM;
    else if (down) acc.y = MOMENTUM;
    else acc.y = 0;
    
    vel.add(acc);
    vel.limit(MAX_SPEED);
    vel.mult(DAMP);
    pos.add(vel);
    
    if (pos.x < size/2) { pos.x = grid.cell_size+size/2; vel.x *= -1; }
    else if (pos.x > width-size/2) { pos.x = width-grid.cell_size-size/2; vel.x *= -1; }
    if (pos.y < size/2) { pos.y = grid.cell_size+size/2; vel.y *= -1; }
    else if (pos.y > (grid.vsize)*grid.cell_size-size/2) { pos.y = (grid.vsize-1)*grid.cell_size-size/2; vel.y *= -1; }
  }
  
  void reflect(PVector n)
  {
    float dot = vel.dot(n);
    float sqmag = n.magSq();
    n.mult(2*dot);
    n.div(sqmag);
    vel.sub(n);    
  }
}