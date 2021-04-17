class Particle
{
  float x;
  float y;
  float xspeed;
  float yspeed;
  
  float RED;
  float GREEN;
  float BLUE;
  float radius;
  
  Particle()
  {
    do
    {
      x = random(-width/2, 3*width/2);
      y = random(-height/2, 3*height/2);
      xspeed = random(MINSPEED, MAXSPEED);
      if (random(1)>0.5) xspeed = -xspeed;
      yspeed = random(MINSPEED, MAXSPEED);
      if (random(1)>0.5) yspeed = -yspeed;
    }
    while ((x > 0 && x < width) || (y > 0 && y < height));
    
    RED = random(0,255);
    GREEN = random(0,255);
    BLUE = random(0,255);
    
    radius = random(2*DIMENSION, MAXRAD);
  }
  
  void update()
  {
    xspeed = xspeed+random(-WABBLE, WABBLE);
    if (xspeed > MAXSPEED) xspeed = MAXSPEED;
    if (xspeed < -MAXSPEED) xspeed = -MAXSPEED;
    
    yspeed = yspeed+random(-WABBLE, WABBLE);
    if (yspeed > MAXSPEED) yspeed = MAXSPEED;
    if (yspeed < -MAXSPEED) yspeed = -MAXSPEED;
   
    x += xspeed;
    y += yspeed;
  }
  
  boolean isOut()
  {
    if (x < -width/2 || x > 3*width/2 || y < -height/2 || y > 3*height/2)
    return true;
    else return false;
  }
}