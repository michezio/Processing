class Obstacle
{
  float left;
  float right;
  float top;
  float bottom;
  PVector center;
  float w;
  float h;
  boolean hasLeft = true;
  boolean hasRight = true;
  boolean hasTop = true;
  boolean hasBottom = true;
  
  Obstacle(PVector pos, float W, float H)
  {
    center = pos;
    w = W;
    h = H;
    left = pos.x - W/2 - RAD;
    right = pos.x + W/2 + RAD;
    top = pos.y - H/2 - RAD;
    bottom = pos.y + H/2 + RAD;
  }
  
  void show()
  {
    fill(50);
    noStroke();
    rect(center.x-w/2,center.y-h/2,w,h);
  }
}