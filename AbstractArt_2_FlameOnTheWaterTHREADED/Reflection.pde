void generateReflection()
{ 
  if (!reflectionCompleted)
  {
    int yy = 0;
    for (int y=0; y<height/4; y++)
    {
      for (int x=0; x<width; x++)
        reflection.set(x,y,get(x,3*height/4-yy-1));
      yy += 3;
    }
    reflectionCompleted = true;
  }
}