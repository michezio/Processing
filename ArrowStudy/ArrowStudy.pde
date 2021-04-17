ArrayList<PVector> points;
ArrayList<Arrow> arrows;

void setup()
{
  size(500,500);  
  points = new ArrayList<PVector>();
  arrows = new ArrayList<Arrow>();
}

void draw()
{
  background(255);
  for (int i=0; i<arrows.size(); ++i)
    arrows.get(i).show();
  arrowBuilder(points);
}

class Arrow
{
  PVector start;
  PVector stop;
  PVector anchor;
  PVector pointL;
  PVector pointR;
  float angle = PI/6.0;
  float wid = 10;
  float head;
  
  
  Arrow( ArrayList<PVector> pts )
  {
    start = pts.get(0);
    stop = pts.get(1);
    anchor = pts.get(2);
    head = new PVector(anchor.x-stop.x,anchor.y-stop.y).heading();
    pointL = new PVector(wid,0).rotate(head+angle).add(stop);
    pointR = new PVector(wid,0).rotate(head-angle).add(stop);
  }
  
  void show()
  {
    stroke(0);
    strokeWeight(2);
    noFill();
    bezier(start.x, start.y, anchor.x, anchor.y, anchor.x, anchor.y, stop.x, stop.y);
    line(stop.x, stop.y, pointL.x, pointL.y);
    line(stop.x, stop.y, pointR.x, pointR.y);
  }
}

void arrowBuilder( ArrayList<PVector> p)
{
  int l = points.size();
  switch (l)
  {
    case 0: return;
    case 1:
    {
      stroke(0);
      line(p.get(0).x, p.get(0).y, mouseX, mouseY);
      return;
    }
    case 2:
    {
      stroke(0);
      noFill();
      bezier(p.get(0).x, p.get(0).y, mouseX, mouseY, mouseX, mouseY, p.get(1).x, p.get(1).y);
      return;
    }
  }
}

void mouseClicked()
{
  if ( points.size() < 3 ) points.add( new PVector(mouseX, mouseY) );
  
  if ( points.size() == 3 )
  {
    arrows.add ( new Arrow(points) );
    points.clear();
  }
}