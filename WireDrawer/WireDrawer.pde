final int SIZE = 12;
final int RAD = 100;
final int DIM = 100;

ArrayList<Point> points;
ArrayList<Line[]> lines;

PImage Point;

boolean frame, pts, holo, tras, update;

void setup()
{
  size(600,480,P2D);
  background(255);
  
  fill(0);
  noStroke();
  ellipse(SIZE,SIZE,SIZE/2,SIZE/2);
  filter(BLUR,2);
  
  tras = true;
  pts = true;
  holo = true;
  frame = true;
  update = true;
  
  Point = createImage(2*SIZE,2*SIZE,HSB);
  Point = get(0,0,2*SIZE,2*SIZE);
  for (int i=0; i<2*SIZE; i++)
    for (int j=0; j<2*SIZE; j++)
    Point.set(i,j,color(0,255-brightness(get(i,j))));
    
  lines = new ArrayList<Line[]>();
  points = new ArrayList<Point>();
  
  background(255);
}

void draw()
{
  println(frameRate);
  
  if (update)            // SOMETHING'S WRONG...
  {
    update = false;
    background(255);
    
    if (pts)
    for (Point P : points)
      P.show();
    if (frame)
    for (Line[] L : lines)
      for (int i=0; i<DIM; i++)  
        if (L[i] == null) break;
        else L[i].show();
  }
}

void mouseClicked()
{
  boolean brk = false;
  for (int i=0; i<points.size(); i++)
  {
    if (dist(points.get(i).pos.x, points.get(i).pos.y, mouseX, mouseY) < SIZE/2)
    {
      points.remove(i);
      brk = true;
    }
    if (brk) break;
  }
  if (!brk) points.add(new Point());
  
  lines.clear();
  
  int k=0;
  lines.add(new Line[DIM]);
  int s=0;
  for (int i=0; i<points.size(); i++)
  {
    Point I = points.get(i);
    for (int j=i+1; j<points.size(); j++)
    {
      Point J = points.get(j);
      if ( dist(I.pos.x, I.pos.y, J.pos.x, J.pos.y) < RAD )
      {
        lines.get(s)[k++] = new Line(I,J);
        if (k == DIM) 
        {
          lines.add(new Line[DIM]);
          s++;
          k=0;
        }
      }
    }
  }
  update = true;
}

void keyPressed()
{
  if (key == 'f')
    frame = !frame;
  else if (key == 'p')
    pts = !pts;
  else if (key == 'h')
    holo = !holo;
  else if (key == 't')
    tras = !tras;
}