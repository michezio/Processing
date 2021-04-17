class Paddle
{
  float x;
  float y;
  float w;
  float h;
  float speed;
  float d = 10;
  float mod = 0;
  boolean left;
  
  Paddle(boolean _left, float _speed, float _width, float _height)
  {
    y = height/2;
    speed = _speed;
    w = _width;
    h = _height;
    left = _left;
    if (left) x = d + w/2;
    else x = width - d - w/2; 
  }
  
  void show()
  {
    update();
    fill(255);
    rect(x-w/2, y-h/2, w, h);
  }
  
  void update()
  {
    move();
    y = y + mod;
    if (y < h/2) y = h/2;
    if (y > height-h/2) y = height-h/2;
  }
  
  void move()
  {
    if (left)
    {
      if (keys[0]) mod = -speed;
      else if (keys[1]) mod = speed;
      else mod = 0;
    }
    else
    {
      if (keys[2]) mod = -speed;
      else if (keys[3]) mod = speed;
      else mod = 0;
    }
  }
  
}