class Shape
{
  ArrayList<PVector> vert;
  PVector origin;
  
  Shape()
  {
    origin = new PVector(random(width),random(height));
    
    vert = new ArrayList<PVector>();
  
    for (int i=0; i<random(3,SIZE); i++)
      vert.add(new PVector(origin.x+random(-EXT,EXT),origin.y+random(-EXT,EXT)));
  }
  
  void show()
  {
    strokeWeight(1);
    stroke(COL,10);
    fill(COL,2);
    beginShape(TRIANGLE_STRIP);
      for (PVector P : vert)
        vertex(P.x,P.y);
    endShape();
  }
}