class Ball
{
  float x;
  float y;
  float r;
  float x_speed;
  float y_speed;
  float angle;
  float speed;
  float incr;
  float motion;
  
  Ball(float _speed, float _radius, float _incr)
  {
    speed = _speed;
    incr = _incr;
    r = _radius;
    reset();  
  }
  
  void show()
  {
    update();
    fill(255);
    ellipse(x, y, r*2, r*2);
  }
  
  void update()
  {
    x_speed = motion * cos(angle);
    y_speed = motion * sin(angle); 
    x = x + x_speed;
    y = y + y_speed;
    bounce();
    checkLimits();
  }
  
  void reset()
  {
    x = width/2;
    y = height/2;
    
    motion = speed;
    
    angle = random(-PI/8, PI/8);
    if (random(1) > 0.5) angle = angle + PI;
  }
  
  void bounce()
  {
    if (x_speed > 0)
    {
      if (y > (right.y - right.h/2) && y < (right.y + right.h/2))
      {
        if (x > right.x - right.w/2 - r)
        {
          x = right.x - right.w/2 - r;
          angle = PI-ANGLE*((y - right.y)/(right.h/2));
          if (right.mod > 0) angle += PI/18;
          if (right.mod < 0) angle += -PI/18;
          motion += incr;
        }
      }
    }
    else
    {
      if (y > (left.y - left.h/2) && y < (left.y + left.h/2))
      {
        if (x < left.x + left.w/2 + r)
        {
          x = left.x + left.w/2 + r;
          angle = ANGLE*((y - left.y)/(left.h/2));
          if (left.mod > 0) angle += PI/18;
          if (left.mod < 0) angle += -PI/18;
          motion += incr;
        }
      }
    }
    
    if (y+r > height)
    {
      y = height - r;
      angle = 2*PI-angle;
    }
    if (y-r < 0)
    {
      y = r;
      angle = 2*PI-angle;
    }
  }
  
  void checkLimits()
  {
    if (x > width + r)
    {
      left_points++;
      reset();
    }
    if (x < -r)
    {
      right_points++;
      reset();
    }
  }
}