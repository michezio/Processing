float GRAV = 0.5;
float JUMP = 10;
float SPEED = 0.4;
float DAMP = 0.96;
float RAD = 10;

class Ball
{
  float x;
  float y;
  float xvel;
  float yvel;
  float xacc;
  float yacc;
  boolean jumpav;
  
  Ball()
  {
    x = RAD;
    y = height - RAD;
    xvel = 0;
    yvel = 0;
    xacc = 0;
    yacc = 0;
  }
  
  void show()
  {
    update();
    fill(0);
    noStroke();
    ellipse(x,y,2*RAD,2*RAD);
  }
  
  void jump()
  {
    if (jumpav)
    {
      yvel = -JUMP;
      jumpav = false;
    }    
  }
  
  void update()
  {
    if (left) xacc = -SPEED;
    else if (right) xacc = SPEED;
    else xacc = 0;
    
    xvel = xvel + xacc;
    xvel *= DAMP;
    yvel = yvel + GRAV;
    
    x = x + xvel;
    y = y + yvel;
    
    checkLimits();
  }
  
  void checkLimits()
  {
    if (x < RAD) { x = RAD; xvel = 0; }
    if (x > width-RAD) { x = width-RAD; xvel = 0; }
    if (y < RAD) { y = RAD; yvel = 0; }
    if (y > height-RAD) { y = height-RAD; yvel = 0; jumpav = true;}
  }
  
  void checkCollision(Field _ogg)
  {
    for (int i=0; i<_ogg.objects.size(); i++)
    {
      if (x > _ogg.objects.get(i).left && x < _ogg.objects.get(i).right && y > _ogg.objects.get(i).top && y < _ogg.objects.get(i).bottom)
      {
        if (xvel > 0 && x < _ogg.objects.get(i).center.x && _ogg.objects.get(i).hasLeft)
        { x = _ogg.objects.get(i).left; xvel = 0; }
        if (xvel < 0 && x > _ogg.objects.get(i).center.x && _ogg.objects.get(i).hasRight)
        { x = _ogg.objects.get(i).right; xvel = 0; }
        if (yvel < 0 && y > _ogg.objects.get(i).center.y && _ogg.objects.get(i).hasBottom)
        { y = _ogg.objects.get(i).bottom; yvel = 0; }
        if (yvel > 0 && y < _ogg.objects.get(i).center.y && _ogg.objects.get(i).hasTop)
        { y = _ogg.objects.get(i).top; yvel = 0; jumpav = true; }
      }  
    }
  }
  
}