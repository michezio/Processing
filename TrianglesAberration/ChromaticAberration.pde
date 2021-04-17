float rx, ry, gx, gy, bx, by, scale = 0;
PImage R, G, B;

void chromaticAberrationSetup(float... offset)
{
  rx = offset.length > 0 ? abs(offset[0]) : 2;
  ry = offset.length > 1 ? abs(offset[1]) : 2;
  gx = offset.length > 2 ? abs(offset[2]) : 1;
  gy = offset.length > 3 ? abs(offset[3]) : 1;
  bx = offset.length > 4 ? abs(offset[4]) : 0;
  by = offset.length > 5 ? abs(offset[5]) : 0;
  if (scale == 0) scale = 1;
  
  R = createImage(width,height,RGB);
  G = createImage(width,height,RGB);
  B = createImage(width,height,RGB);
  
  blendMode(SCREEN);
}

void chromaticAberrationScale(float sc)
{
  scale = sc > 0 ? sc : 1;  
}

void chromaticAberration()
{
  loadPixels();
  
  for (int i=0; i<width*height; ++i)
  {
    R.pixels[i] = color(red(pixels[i]),0,0);
    G.pixels[i] = color(0,green(pixels[i]),0);
    B.pixels[i] = color(0,0,blue(pixels[i]));
  }

  R.updatePixels();
  G.updatePixels();
  B.updatePixels();
  
  clear();
  
  image(R, -rx*scale, -ry*scale, width + 2*rx*scale, height + 2*ry*scale);
  image(G, -gx*scale, -gy*scale, width + 2*gx*scale, height + 2*gy*scale);
  image(B, -bx*scale, -by*scale, width + 2*bx*scale, height + 2*by*scale);
}