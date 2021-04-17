class PButton
{
  String name;
  float x;
  float y;
  float w;
  float h;
  color col;
  boolean isOn = false;
  
  PButton(String _name, float _x, float _y, float _w, float _h, color _col)
  {
    name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    col = _col;
  }
  
  void setText(String text)
  {
    name = text;
  }
  
  void show()
  {
    noStroke();
    fill(col);
    rect(x,y,w,h);
    fill(255);
    textSize(24);
    text(name, x+w/5, y+2*h/3);
    textSize(20);
    text("GRID", x+1, y+30);
 
  }
  
  boolean mouseOver()
  {
    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) return true;
    return false;
  }
  
  void setColor(color newColor)
  {
    col = newColor;
  }
}