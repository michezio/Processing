float DIMENSION = 2;

class Point
{
  float x;
  float y;
  color shade;
  
  Point(float index)
  {
    x = index * width/PTS;
    y = height/2;
  }
  
  void setColor(color _shade)
  {
    shade = _shade;
  }
  
  void show()
  {
    fill(shade);
    noStroke();
    ellipse(x,y,DIMENSION,DIMENSION);
  }
  
  void setVertical(float value)
  {
    y = value;
  }
  
}