void newUndo()
{
  undoState = false;
  sprite.newUndo();
}
void undo()
{
  if (undoState) return;
  undoState = true;
  println("undoing");
  sprite.undo();
}

void saveSprite()
{
  PGraphics img = createGraphics(height,height,JAVA2D);
  
  sprite.save(img);
  
  String day = "";
  String time = "";
  day += (year()-2000);
  if (month() < 10) day += "0"+month();
  else day += month();
  if (day() < 10) day += "0"+day();
  else day += day();
  if (hour() < 10) time += "0"+hour();
  else time += hour();
  if (minute() < 10) time += "0"+minute();
  else time += minute();
  if (second() < 10) time += "0"+second();
  else time += second();
  
  String saveName = "Sprite"+day+time+".png";
  
  img.save(saveName);
}

void generateBackground()
{
  checkboard = createImage(height,height,RGB);
  
  boolean iT = false;
  boolean jT = false;
  
  for (int i=0; i<checkboard.width; ++i)
  {
    if (i % 10 == 0) iT = !iT;
    jT = false;
    for (int j=0; j<checkboard.height; ++j)
    {
      if (j % 10 == 0) jT = !jT;
      
      if (jT != iT) checkboard.set(i,j,color(180));
      else checkboard.set(i,j,color(120));
    }
  }
}