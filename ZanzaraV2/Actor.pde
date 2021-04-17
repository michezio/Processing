float MOMENTUM = 0.1;
float MAX_SPEED = 5;
float DAMP = 0.985;
float SIZE = 40;
float GRAVITY = 0.2;
float JUMP_SPEED = -5;
float BOUNCE = 0.5;

class Actor
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  float sqSize;
  
  Actor()
  {
    size = SIZE;
    sqSize = (size/2.0)*(size/2.0);
    pos = new PVector(width/2, height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void display()
  {
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update()
  {
    if (left) acc.x = -MOMENTUM;
    else if (right) acc.x = MOMENTUM;
    else acc.x = 0;
    if (up) vel.y = JUMP_SPEED;
    
    acc.y = GRAVITY;
    
    vel.add(acc);
    vel.mult(DAMP);
    pos.add(vel);
    
    if (pos.x < size/2) { pos.x = grid.cell_size+size/2; vel.x *= -1; }
    else if (pos.x > width-size/2) { pos.x = width-grid.cell_size-size/2; vel.x *= -1; }
    if (pos.y < size/2) { pos.y = grid.cell_size+size/2; vel.y *= -1; }
    else if (pos.y > (grid.vsize)*grid.cell_size-size/2) { pos.y = (grid.vsize-1)*grid.cell_size-size/2; vel.y *= -1; }
  }
}