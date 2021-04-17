class Point
{
  PVector pos;
  
  Point()
  {
    pos = new PVector(mouseX, mouseY);
  }
  
  void show()
  {
    if (holo) image(Point, pos.x-SIZE, pos.y-SIZE);
    else
    {
      noStroke();
      fill(0);
      ellipse(pos.x,pos.y, SIZE, SIZE);
    }
  }
}