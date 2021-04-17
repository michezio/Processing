ArrayList<Shape> shape;

void setup()
{
  size(800,600,P2D);
  background(BKG);
  
  shape = new ArrayList<Shape>();
  
  for (int i=0; i<NUMB; i++)
    shape.add(new Shape());
  
}

void draw()
{
  clear();
  
  for (Shape S : shape)
    S.show();  
}