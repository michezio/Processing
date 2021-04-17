void floodFill(int posX, int posY)
{
  if (baseColor == color(RED,GREEN,BLUE)) return;
  else if (get(posX,posY) != baseColor) return;
  else
  {
    set(posX,posY, color(RED,GREEN,BLUE));
    if (posX+1 < width) 
      if (get(posX+1,posY) == baseColor) updateList.add(new Pointer(posX+1, posY));
    if (posX-1 >= 0)
      if (get(posX-1,posY) == baseColor) updateList.add(new Pointer(posX-1, posY));
    if (posY+1 < height) 
      if (get(posX,posY+1) == baseColor) updateList.add(new Pointer(posX, posY+1));
    if (posY-1 >= 0)
      if (get(posX,posY-1) == baseColor) updateList.add(new Pointer(posX, posY-1));
  }  
}

void floodFillRec(int posX, int posY)
{
  counter++;
  if (counter > 3000) {counter--; return; }
  if (baseColor == color(RED,GREEN,BLUE)) { counter--; return; }
  else if (get(posX,posY) != baseColor) { counter--; return; }
  else
  {
    set(posX,posY, color(RED,GREEN,BLUE));
    int starter = floor(random(4));
    
    while (starter != -1)
    {
    switch (starter)
    {
      case 0:
      if (posX+1 < width) 
        if (get(posX+1,posY) == baseColor) floodFillRec(posX+1,posY);
      case 1:
      if (posY+1 < height) 
        if (get(posX,posY+1) == baseColor) floodFillRec(posX,posY+1);
      case 2:
      if (posX-1 >= 0)
        if (get(posX-1,posY) == baseColor) floodFillRec(posX-1,posY); 
      case 3:
      if (posY-1 >= 0)
        if (get(posX,posY-1) == baseColor) floodFillRec(posX,posY-1);
    }
    if (starter != 0) starter = 0;
    else starter = -1;
    }
  }
  counter--;
}