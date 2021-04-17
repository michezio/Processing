class Stream
{
  float startX;
  float startY;
  float fade;
  float dim;
  ArrayList<Symbol> list;
  int interval;
  boolean onScreen = true;
  int maxLength;
  
  Stream ( float xx, float yy, float dims )
  {
    interval = 0;
    startX = xx;
    startY = yy;
    fade = random(0.93,0.999);
    maxLength = round(random(10,50));
    dim = dims;
    list = new ArrayList<Symbol>();
    addElement();
  }
  
  void addElement()
  {
    if (onScreen && startY < height && list.size() < maxLength)
    {
      startY = startY + (GAP+dim);
      if (list.size() > 0) list.get(list.size()-1).white = false;
      list.add(new Symbol(startX,startY,dim,fade));
    }
    else 
    {
      onScreen = false;
      list.get(list.size()-1).white = false;
    }
  }
  
  void show()
  {
    if (++interval > INTERVAL)
    {
      addElement();
      interval = 0;
    }
    for (int i=list.size()-1; i>=0; i--)
    {
      Symbol S = list.get(i);
      if (alpha(S.shade)<30) list.remove(i);
      else S.show();
    }
  }
 
}