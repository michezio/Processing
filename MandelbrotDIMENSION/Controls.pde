void keyPressed()
{
  update = true;
  if (key == 'q')
  {
    scale = scale * ZOOM; 
  }
  if (key == 'a')
  {
    if (scale <= 2)
    {
      scale = scale / ZOOM;
    }
  }
  if (key == 'w')
  {
    ITERATIONS += INCR;
  }
  if (key == 's')
  {
    ITERATIONS -= INCR;
  }
  if (key == 'e')
  {
    ITERATIONS += 1;
  }
  if (key == 'd')
  {
    ITERATIONS -= 1;
  }
  if (key == 'c')
  {
    scheme = ++scheme % COLORS;
  }
  if (key == 'z')
  {
    scale = 1.5;
    xshift = -0.75;
    yshift = 0;
  }
  if (key == 'j')
  {
    xshift += -(scale*2/100);
  }
  if (key == 'l')
  {
    xshift += (scale*2/100);
  }
  if (key == 'i')
  {
    yshift += -(scale*2/100);
  }
  if (key == 'k')
  {
    yshift += (scale*2/100);
  }
  if (key == 'v')
  {
    crossair = !crossair;
  }
  if (key == 'b')
  {
    smooth = !smooth;
  }
  
  if (ITERATIONS > 1000) ITERATIONS = 1000;
  if (ITERATIONS < 1) ITERATIONS = 1;
  //if (xshift > 1) xshift = 1;
  //if (xshift < -1) xshift = -1;
  //if (yshift > 1) yshift = 1;
  //if (yshift < -1) yshift = -1;
 
  
  print("DEPTH: ");
  print(scale);
  print(" - DETAILS: ");
  print(ITERATIONS);
  println();
}

void mouseClicked()
{
  update = true;
  xshift += map(mouseX,0,width,-scale,scale);
  yshift += map(mouseY,0,height,-scale,scale);
  //scale = scale * ZOOM;
}