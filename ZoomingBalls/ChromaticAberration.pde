float rx, ry, gx, gy, bx, by, scale;
PImage R, G, B;

void chromaticAberrationSetup(float sc, float... offset)
{
  rx = offset.length > 0 ? abs(offset[0])*sc : 2*sc;
  ry = offset.length > 1 ? abs(offset[1])*sc : 2*sc;
  gx = offset.length > 2 ? abs(offset[2])*sc : sc;
  gy = offset.length > 3 ? abs(offset[3])*sc : sc;
  bx = offset.length > 4 ? abs(offset[4])*sc : 0;
  by = offset.length > 5 ? abs(offset[5])*sc : 0;
  scale = sc > 0 ? sc : 1;
  
  R = createImage(width,height,RGB);
  G = createImage(width,height,RGB);
  B = createImage(width,height,RGB);
  
  blendMode(SCREEN);
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
  
  image(R, -rx, -ry, width + 2*rx, height + 2*ry);
  image(G, -gx, -gy, width + 2*gx, height + 2*gy);
  image(B, -bx, -by, width + 2*bx, height + 2*by);
}