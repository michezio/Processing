final int ARROW_SIZE = 5;
final int ARROW_POINT = 20;
final float ARROW_ANGLE = PI/6;

class Arrow
{
  PVector start;
  PVector stop;
  PVector anchor;
  PVector pointL;
  PVector pointR;
  color col;
  float angle = ARROW_ANGLE;
  float wid = ARROW_POINT;
  float head;
  boolean bezier;
  
  
  Arrow( ArrayList<PVector> pts, color shade )
  {
    col = shade;
    start = pts.get(0);
    stop = pts.get(1);
    anchor = pts.get(2);
    if (dist(anchor.x, anchor.y, stop.x, stop.y) < 4*ARROW_POINT/3)
    {
      anchor.set((start.x+stop.x)/2.0,(start.y+stop.y)/2.0);
      bezier = false;
    }
    else bezier = true;
    head = new PVector(anchor.x-stop.x,anchor.y-stop.y).heading();
    pointL = new PVector(wid,0).rotate(head+angle).add(stop);
    pointR = new PVector(wid,0).rotate(head-angle).add(stop);
    
  }
  
  void show()
  {
    stroke(col);
    strokeWeight(ARROW_SIZE);
    noFill();
    if (bezier) bezier(start.x, start.y, anchor.x, anchor.y, anchor.x, anchor.y, stop.x, stop.y);
    else line(start.x, start.y, stop.x, stop.y);
    line(stop.x, stop.y, pointL.x, pointL.y);
    line(stop.x, stop.y, pointR.x, pointR.y);
  }
}

void arrowBuilder( ArrayList<PVector> p )
{
  int l = points.size();
  switch (l)
  {
    case 0: return;
    case 1:
    {
      stroke(0);
      strokeWeight(1);
      line(p.get(0).x, p.get(0).y, mouseX, mouseY);
      return;
    }
    case 2:
    {
      stroke(0);
      strokeWeight(1);
      noFill();
      bezier(p.get(0).x, p.get(0).y, mouseX, mouseY, mouseX, mouseY, p.get(1).x, p.get(1).y);
      return;
    }
  }
}