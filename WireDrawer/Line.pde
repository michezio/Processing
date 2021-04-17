class Line
{
  Point point1;
  Point point2;
  
  Line(Point p1, Point p2)
  {
    point1 = p1;
    point2 = p2;
  }
  
  void show()
  {
    if (tras) stroke(0,100);
    else stroke(0);
    strokeWeight(2);
    line(point1.pos.x, point1.pos.y, point2.pos.x, point2.pos.y);
  }
}