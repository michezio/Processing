class Pixel
{
  float x;
  float y;
  float R;
  float G;
  float B;
  boolean isOn = false;
  float dist;
  
  Pixel(int xx, int yy)
  {
    x = xx * DIMENSION + DIMENSION / 2;
    y = yy * DIMENSION + DIMENSION / 2;
  }
  
  void show()
  {
    noStroke();
    fill(color(R,G,B));
    rect(x-DIMENSION/2, y-DIMENSION/2, DIMENSION, DIMENSION);
  }
  
  void update(Particle point)
  {
    float dist = distance(point);
    
    if (dist <= point.radius)
    {  
      R += (1-dist/point.radius)*SENS*point.RED/255;
      if (R > 255) R = 255;
      G += (1-dist/point.radius)*SENS*point.GREEN/255;
      if (G > 255) G = 255;
      B += (1-dist/point.radius)*SENS*point.BLUE/255;
      if (B > 255) B = 255;
    }
    if (dist > point.radius && isOn)
    {
      R -= FADE*R/255;
      if (R < 0) R = 0;
      G -= FADE*G/255;
      if (G < 0) G = 0;
      B -= FADE*B/255;
      if (B < 0) B = 0;
    }
    
    if (R == 0 && G == 0 && B == 0) isOn = false;
    else isOn = true;
 
  }
    
  float distance(Particle point)
  {
    return sqrt((x - point.x)*(x - point.x)+(y - point.y)*(y - point.y));
  }
}