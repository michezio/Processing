class Paddle
{
  float x;
  float y;
  float w;
  float h;
  float speed;
  float d = 10;
  float xmod = 0;
  float ymod = 0;
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
    y = y + ymod;
    x = x + xmod;
    if (left)
    {
      if (x < d + w/2) x = d + w/2;
      if (x > width/4) x = width/4;
    }
    else 
    {
      if (x > width - d - w/2) x = width - d - w/2;
      if (x < 3*width/4) x = 3*width/4;
    }
    if (y < h/2) y = h/2;
    if (y > height-h/2) y = height-h/2;
  }
  
  void move()
  {
    if (left)
    {
      if (keysL[0]) ymod = -speed;
      else if (keysL[1]) ymod = speed;
      else ymod = 0;
      if (keysL[2]) xmod = -speed;
      else if (keysL[3]) xmod = speed;
      else xmod = 0;
    }
    else
    {
      if (keysR[0]) ymod = -speed;
      else if (keysR[1]) ymod = speed;
      else ymod = 0;
      if (keysR[2]) xmod = -speed;
      else if (keysR[3]) xmod = speed;
      else xmod = 0;
    }
  }
  
}