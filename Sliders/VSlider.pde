class VSlider
{
  float x, y;
  float h;
  float dim;
  float value;
  float position;
  color shade;
  String name;
  boolean active;
  
  VSlider(String _name, float _x, float _y, float _h, float _dim, color _shade) 
  {
    x = _x;
    y = _y;
    h = _h;
    dim = _dim;
    shade = _shade;
    name = _name;
    position = y + h;
    value = 0;
  }
  
  void show()
  {
    move();
    fill(127);
    noStroke();
    rect(x-dim/10,y,dim/5,h);
    fill(shade);
    ellipse(x, position, dim*2, dim*2);
  }
  
  float getValue()
  {
    return value;
  }
  
  void move()
  {
    if (active)
    {
      position = mouseY;
      if (position > y+h) position = y+h;
      if (position < y) position = y;
      value = 1 - ((position-y)/h);
    }
  }
  
  void mouseOver(boolean stat)
  {
    if (stat)
    {
      float d = sqrt((x-mouseX)*(x-mouseX)+(position-mouseY)*(position-mouseY));
      if( d < dim ) active = true;
      else active = false;
    }
    else active = false;
  }
  
}