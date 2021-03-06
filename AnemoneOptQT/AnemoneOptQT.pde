final int COUNT = 1500;
final float FORCE = 10;
final float DAMP = 1;
final float VISC = 0.2;
final int THRESH = 2500;
final int SIZE = 5;
final int SIGHT = 50;

ArrayList<Ball> b;
QuadTree<Ball> qt;

int hue;

PVector grav;

void setup()
{
  colorMode(HSB);

  //fullScreen();
  size(1300,600);
  b = new ArrayList<Ball>();
  for (int i=0; i<COUNT; i++) {
    b.add(new Ball(random(width), random(height)));
  }
  //qt = new QuadTree<Ball>(width,height,3);
  background(0);
}

void draw()
{
  noStroke();
  fill(0);
  rect(0,0,width,height);
  
  qt = new QuadTree<Ball>(width,height,30);
  for (Ball B : b) {
    B.stop();
    qt.insert(B);
  }
  
  for (Ball A : b)
  { 
    ArrayList<Ball> toCheck = qt.query(new qtRectangle(A.x,A.y,SIGHT,SIGHT));
    toCheck.remove(A);
    for (Ball B : toCheck)
    {
      A.interact(B);
    }
    A.update();
    A.displayLine();
  }
  
  //pushStyle();
  //strokeWeight(1);
  //qt.show(color(255,50));
  //popStyle();
  
  println(frameRate);
}

void mouseDragged()
{
  for (int i=0; i<3; i++) {
    b.add(new Ball(mouseX+random(-10,10), mouseY+random(-10,10)));
    if (b.size() > COUNT)
    b.remove(0);
  }
}

void mouseReleased()
{
  hue = floor(random(256));
}
