class Food
{
  PVector pos;
  PVector vel;
  
  Food()
  {
    pos = new PVector(random(width),random(height));
    vel = new PVector(random(F_SPEED),0);
    vel.rotate(random(TWO_PI));
  }
 
  void show()
  {
    noStroke();
    fill(85,255,255);
    ellipse(pos.x,pos.y,F_SIZE,F_SIZE);
  }
  
  void update()
  {
    pos.add(vel);
    if (pos.x > width+F_SIZE/2) pos.x = -F_SIZE/2;
    if (pos.x < -F_SIZE/2) pos.x = width+F_SIZE/2;
    if (pos.y > height+F_SIZE/2) pos.y = -F_SIZE/2;
    if (pos.y < -F_SIZE/2) pos.y = height+F_SIZE/2;
  }
}