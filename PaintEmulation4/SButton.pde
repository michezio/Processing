class SButton
{
  float x;
  float y;
  float w;
  float h;
  color col;
  boolean isOn = false;
  
  SButton(float _x, float _y, float _w, float _h, color _col)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    col = _col;
  }
  
  void show()
  {
    
    if (isOn) 
      if (col == color(255,255,255)) stroke(color(200,200,200));
      else stroke(color(255,255,255));
    else noStroke();
    strokeWeight(2);
    fill(col);
    rect(x,y,w,h);
 
  }
  
  void mouseOver()
  {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
    {
      RED = red(col);
      GREEN = green(col);
      BLUE = blue(col);
    }
    if (color(RED,GREEN,BLUE) == col) isOn = true;
    else isOn = false;    
  }
  
  void setColor(color newColor)
  {
    col = newColor;
  }
}