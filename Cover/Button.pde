class Button
{
  float x;
  float y;
  float dim;
  int R, G, B;
  boolean status;
  float mod;
  
  Button(float _x, float _y, float _dim, int _R, int _G, int _B)
  {
    x = _x;
    y = _y;
    dim = _dim;
    R = _R;
    G = _G;
    B = _B;
    status = false;
  }
  
  void show()
  {
    mouseOver();
    fill(floor(R*mod),floor(G*mod),floor(B*mod));
    noStroke();
    ellipse(x,y,dim,dim);
  }
  
  void mouseOver()
  {
    float dist = sqrt((x-mouseX)*(x-mouseX)+(y-mouseY)*(y-mouseY));
    if (dist < dim/2) mod = 1.2;
    else mod = 1;
  }
  
  void check()
  {
    
  }
}