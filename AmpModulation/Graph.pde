class Graph
{
  color col;
  color bkg;
  int dim;
  float x;
  float y;
  float w;
  float h;
  float gap;
  
  Graph( int dimension, color front, color background, float _x, float _y, float _w, float _h )
  {
    dim = dimension;
    col = front;
    bkg = background;
    x = _x;
    y = _y + _h/2;
    w = _w;
    h = _h;
    gap = w/dim;
  }
  
  void show(float[] point)
  {
    fill(bkg);
    noStroke();
    rect(x, y-h/2, w, h);
    for(int i=0; i<dim-1; i++)
    {
      stroke(col);
      line(x+i*gap,y+(point[i]*h/2), x+(i+1)*gap,y+(point[i+1]*h/2));
    }
  }
}