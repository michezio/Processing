class Symbol
{
  float x;
  float y;
  char value;
  float size;
  color shade;
  float fade;
  boolean white;
  
  Symbol (float xx, float yy, float dim, float fad)
  {
    shade = color(MATRIXCOLOR,200,200);
    fade = fad;
    x = xx;
    y = yy;
    size = dim;
    float casus = random(1);
    int num;
    if (casus > 0.66)
      num = round(random(97,122));
    else if (casus > 0.33)
      num = round(random(65,90));
    else num = round(random(48,57));
    
    value = char(num);
    white = true;
  }
  
  void update()
  {
    if (random(1) > MUTATION)
    {
      float casus = random(1);
      int num;
      if (casus > 0.66)
        num = round(random(97,122));
      else if (casus > 0.33)
        num = round(random(65,90));
      else num = round(random(48,57));
      value = char(num);
    }
    if (white) shade = color(MATRIXCOLOR,50,255,255);
    else shade = color(MATRIXCOLOR,255,255,alpha(shade)*fade);
  }
  
  void show()
  {
    update();
    fill(shade);
    textSize(size);
    text(value, x,y);
  }
}