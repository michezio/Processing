class HSlider
{
  float x, y;
  float w;
  float dim;
  float value;
  float position;
  color shade;
  String name;
  boolean active;
  
  HSlider(String _name, float _x, float _y, float _w, float _dim, color _shade) 
  {
    x = _x;
    y = _y;
    w = _w;
    dim = _dim;
    shade = _shade;
    name = _name;
    position = x;
    value = 0;
  }
  
  void show()
  {
    move();
    fill(127);
    noStroke();
    rect(x,y-dim/10,w,dim/5);
    fill(shade);
    ellipse(position, y, dim*2, dim*2);
  }
  
  float getValue()
  {
    return value;
  }
  
  void move()
  {
    if (active)
    {
      position = mouseX;
      if (position > x+w) position = x+w;
      if (position < x) position = x;
      value = (position-x)/w;
    }
  }
  
  void mouseOver(boolean stat)
  {
    if (stat)
    {
      float d = sqrt((position-mouseX)*(position-mouseX)+(y-mouseY)*(y-mouseY));
      if( d < dim ) active = true;
      else active = false;
    }
    else active = false;
  }
  
}