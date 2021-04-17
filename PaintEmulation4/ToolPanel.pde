float SPACE = 5;

class ToolPanel
{
  String[] names;
  int dimension;
  float x;
  float y;
  float w;
  float h;
  color col;
  int tool;
  
  ToolPanel( int _dimension, float _x, float _y, float _w, float _h, color _col )
  {
    dimension = _dimension;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    col = _col;
    names = new String[dimension];
  }
  
  void show()
  {
    for (int i=0; i<dimension; i++)
    {
      if (i == tool)
      {
        stroke(color(255,255,255));
        strokeWeight(2);
      }
      else noStroke();
      fill(col);
      rect(x,y+i*(h+SPACE),w,h);
      fill(color(255,255,255));
      textSize(h/2);
      text(names[i], x+2, y+i*(h+SPACE)+2*h/3);
    }
  }
  
  void mouseOver()
  {
    if (mouseX > x && mouseX < x+w)
      if (mouseY > y && mouseY < y+(dimension-1)*(h+SPACE)+h)
        {
          for (int i=0; i<dimension; i++)
            if (mouseY > y+i*(h+SPACE) && mouseY < y+i*(h+SPACE)+h) tool = i;
        }
  }
  
  void setNames(int index, String name)
  {
    names[index] = name;
  }
  
  String getTool()
  {
    return names[tool];
  }
}