final int COUNT = 600;
final float FORCE = 10;
final float VISC = 0.15;
final int THRESH = 2500;
final int SIZE = 5;
final int SIGHT = 20;

ArrayList<Ball> b;
QuadTree<Ball> qt;

int hue;
boolean recording;

PVector grav;

void setup()
{
  colorMode(HSB);
  frameRate(30);
  //fullScreen();
  size(600,600);
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
      float vel = (A.v.mag() + B.v.mag())/2;
      float size = (A.mass + B.mass)/2;
      stroke(map(vel, 0, 8, 0, 255));
      strokeWeight(size/2);
      line(A.p.x, A.p.y, B.p.x, B.p.y);
    }
    A.update();
    //A.dim = 1;
    //A.display();
  }
  
  //pushStyle();
  //strokeWeight(1);
  //qt.show(color(255,50));
  //popStyle();
  
  //println(frameRate);
  if (recording) saveFrame("H:/Users/Shin/Pictures/DesignConcepts/SavedFrames/frame-####.gif");
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

void keyPressed() {
  if (key == ' ')
    saveFrame("H:/Users/Shin/Pictures/DesignConcepts/SavedFrames/singleFrame-####.png");
  
  if (key == 's')
    recording = !recording;
}
