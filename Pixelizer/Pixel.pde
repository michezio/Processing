class Pixel
{
  float x;
  float y;
  float R;
  float G;
  float B;
  
  Pixel(int xx, int yy)
  {
    x = xx * DIMENSION + DIMENSION / 2;
    y = yy * DIMENSION + DIMENSION / 2;
  }
  
  void show()
  {
    update();
    noStroke();
    fill(color(R,G,B));
    rect(x-DIMENSION/2, y-DIMENSION/2, DIMENSION, DIMENSION);
  }
  
  void update()
  {
    float dist = distance();
    
    if (dist > RADIATION)
    {
      R = R * PERMANENCE;
      G = G * PERMANENCE;
      B = B * PERMANENCE;
    }
    //else if (dist < RADIATION)
    //{
    //  R = R * 1/PERMANENCE;
    //  G = G * (1/PERMANENCE);
    //  B = B * (1/PERMANENCE);
    //}
    else
    {
      R = RED * (1-dist/RADIATION);
      G = GREEN * (1-dist/RADIATION);
      B = BLUE * (1-dist/RADIATION);
    }
  }
    
  float distance()
  {
    return sqrt((x - mouseX)*(x - mouseX)+(y - mouseY)*(y - mouseY));
  }
}