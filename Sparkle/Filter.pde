float[][] coef =
{
  { 0.05, 0.05, 0.05 },
  { 0.05, 0.6, 0.05 },
  { 0.05, 0.05, 0.05 }
};

float [][] coef2 =
{
  { 1, 1, 1 },
  { 1, 1, 1 },
  { 1, 1, 1 }
};   

void LPFilter()
{
  loadPixels();
  int x = width/2;
  int y = height/2;
  average(x,y);
  
  int c = 0;
  int s = 1;
  
  while (c < max(width,height))
  {
    for(int i=0; i < c; i++)
    {
      x = x+s;
      if (x < 0 || x >= width) break;
      average(x,y);
    }
    for(int i=0; i < c; i++)
    {
      y = y+s;
      if (y < 0 || y >= height) break;
      average(x,y);
    }
    c++;
    s = -s;
  }
}

void average(int x, int y)
{
  float R = 0;
  float G = 0;
  float B = 0;
  
  for (int i = x-1; i <= x+1; i++)
  {
    if (i < 0 || i >= width) continue;
    for (int j = y-1; j <= y+1; j++)
    {
      if (j < 0 || j >= height) continue;
      
      color c = pixels[i + width*j];
      R += red(c)*coef[i-x+1][j-y+1];
      G += green(c)*coef[i-x+1][j-y+1];
      B += blue(c)*coef[i-x+1][j-y+1];
    }
  } 
  set(x,y,color(R,G,B));
}

void LPFilter2(int lift)
{
  PImage img = get(0,0,width,height);
  float R = 0;
  float G = 0;
  float B = 0;
  int m = 0;
  
  for(int x=0; x<width; x++)
  {
    for(int y=0; y<height; y++)
    {
      R = G = B = 0;
      for (int i=-1; i<=1; i++)
      {
        if (x+i < 0 || x+i >= width) continue;
        for (int j=-1; j<=1; j++)
        {
          if (y+j < 0 || y+j >= height) continue;
          color c = img.get(x+i,y+j);
          float mult = 1;
          if (i == 0 && j == 0) mult = lift;
          else mult = 1;
          R += red(c)*mult;
          G += green(c)*mult;
          B += blue(c)*mult;
          m++;
        }
      }
      m += lift-1;
      R = R/m;
      G = G/m;
      B = B/m;
      m = 0;
      set(x,y,color(R,G,B));
    }
  }
}

void LPFilter3()
{
  float norm = 0;
  for (int m=0; m<3; m++)
  for (int n=0; n<3; n++)
  norm += coef2[m][n];
  
  for (int m=0; m<3; m++)
  for (int n=0; n<3; n++)
  coef2[m][n] /= norm;
  
  PImage img = get(0,0,width,height);
  float R = 0;
  float G = 0;
  float B = 0;
  
  for (int x=0; x<width; x++)
  {
    for (int y=0; y<height; y++)
    {
      R = G = B = 0;
      for (int i=x-1; i<=x+1; i++)
      {
        if (i<0 || i>width) continue;
        for (int j=y-1; j<=y+1; j++)
        {
          if (j<0 || j>height) continue;
          color c = img.get(i,j);
          R += red(c)*coef2[i-x+1][j-y+1];
          G += green(c)*coef2[i-x+1][j-y+1];
          B += blue(c)*coef2[i-x+1][j-y+1];
        }
      }
      set(x,y,color(R,G,B));
    }
  }
}