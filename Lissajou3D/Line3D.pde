class Line3D
{
  PVector[] pos;
  int dim;
  float current;
  boolean initiated;
  
  Line3D(int DIM)
  {
    dim = DIM;
    pos = new PVector[DIM];
    for (int i=0; i<dim; i++)
      pos[i] = new PVector(0,0,0);
    initiated = false;
  }
  
  void update(PVector p)
  {   
    for (int i=0; i<dim-1; i++)
    {
      if (!initiated) pos[i] = p;
      else pos[i] = pos[i+1].copy();
    }
    
    if (!initiated) initiated = true;
    
    pos[dim-1] = p;
  }
  
  void show()
  {
    current += 1 + HUESHIFT;
    strokeWeight(4);
    for (int i=dim-1; i>0; i--)
    {
      stroke(((current+i)*10*255/dim)%256, 255, 255, i*255/dim);
      line(pos[i].x,pos[i].y,pos[i].z,pos[i-1].x,pos[i-1].y,pos[i-1].z);
    }
  }
}