float MOMENTUM = 0.55;
float MAX_SPEED = 100;
float DAMP = 0.985;
float SIZE = 20;

class Actor
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  
  Actor()
  {
    size = SIZE;
    pos = new PVector(width/2, height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void display()
  {
    update();
    fill(0);
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
    vel.mult(DAMP);
    pos.add(vel);
    
    if (pos.x < grid.cell_size+size/2) { pos.x = grid.cell_size+size/2; vel.x = 0; }
    else if (pos.x > width-grid.cell_size-size/2) { pos.x = width-grid.cell_size-size/2; vel.x = 0; }
    if (pos.y < grid.cell_size+size/2) { pos.y = grid.cell_size+size/2; vel.y = 0; }
    else if (pos.y > (grid.vsize-1)*grid.cell_size-size/2) { pos.y = (grid.vsize-1)*grid.cell_size-size/2; vel.y = 0; }
  }
}