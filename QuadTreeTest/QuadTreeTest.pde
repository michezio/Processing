// Processing Test module

final int MAXSIZE = 10000;
final float RECTDIM = 50;
final float DIM = 4;
final int SPEED = 1;

boolean qtActive = false;
boolean qtShow = false;
boolean rShow = true;
int qtCap = 10;

QuadTree<Point> qt;
ArrayList<Point> pts;
qtCircle r;

void setup() {
	size(800,800,P3D);
	pts = new ArrayList<Point>(MAXSIZE+1);
  r = new qtCircle(mouseX, mouseY, RECTDIM);
}

void draw() {
  background(0);
  
	if (qtActive) qt = new QuadTree<Point>(width, height, qtCap);
	for (Point p : pts) {
    p.update();
		if (qtActive) qt.insert(p);
	}
  
  if (qtActive) {
    for (Point p : pts) {
      ArrayList<Point> inRange = qt.query(new qtRectangle(p.x, p.y, p.dim, p.dim));
      for (Point x : inRange) {
        if (p == x) continue;
        p.bounce(x);
      }
    }
    if (rShow) {
      ArrayList<Point> inRange = qt.query(r);
      for (Point p : inRange) {
        p.setHighlight(true);
      }
    }
  }
  else {
    for (Point p : pts) {
      for (Point x : pts) {
        if (p == x) continue;
        p.bounce(x);
      }
      if (rShow) {
        if ((p.x-r.x)*(p.x-r.x)+(p.y-r.y)*(p.y-r.y) < r.r*r.r) {
          p.setHighlight(true);
        }
      }
    }
    
  }
  
  for (Point p : pts) p.show();

	if (qtShow) qt.show(color(255,100));
  
  if (rShow) {
    r.x = mouseX;
    r.y = mouseY;
    pushStyle();
      noFill();
      stroke(0,255,0);
      //rectMode(CENTER);
      ellipse(r.x, r.y, r.r*2, r.r*2); 
    popStyle();
  }
}

void mouseDragged() {
  for (int i=0; i<10; ++i) {
    pts.add(new Point(mouseX + random(-100,100), mouseY + random(-100,100)));
    if (pts.size() > MAXSIZE) pts.remove(0);
  }
}

void mouseClicked() {
  pts.add(new Point(mouseX, mouseY));
  if (pts.size() > MAXSIZE) pts.remove(0);
}

void keyPressed() {
  if (key == ' ') {
    qtActive = !qtActive;
    if (qtActive) println("QuadTree: ENABLED (" + qtCap + ")");
    else println("QuadTree: DISABLED");
  }
  
  if (key == 'd') {
    qtShow = !qtShow;
    if (qtShow) println("QuadTree render: ENABLED");
    else println("QuadTree render: DISABLED");
  }
  
  if (key == 's') {
    qtCap = (qtCap == MAXSIZE) ? MAXSIZE : ++qtCap;
    println("QuadTree Capacity: " + qtCap);
  }
  if (key == 'a') {
    qtCap = (qtCap == 1) ? 1 : --qtCap;
    println("QuadTree Capacity: " + qtCap);
  }
  
  if (key == 'r') {
    rShow = !rShow;
    if (rShow) println("Range calculation: ACTIVE");
    else println("Range calculation: INACTIVE");
  }
  
  if (key == 'f') println("Frame Rate: " + frameRate);
}

// ---------------------------------------------------------------------

class Point extends qtElement {
  float dim;
  boolean highlight;
  boolean collided;
  PVector v;

  Point(float x, float y) {
    super(x, y);
    this.dim = DIM;
    this.highlight = false;
    this.collided = false;
    this.v = PVector.fromAngle(random(TWO_PI));
    v.mult(SPEED);
  }

  void bounce(Point p) {
    if ((p.x-x)*(p.x-x)+(p.y-y)*(p.y-y) < dim*dim) {
      collided = true;
    }
  }

  void update() {
    x += v.x;
    y += v.y;
    
    x = (x>width) ? 0 : ((x<0) ? width : x);
    y = (y>height) ? 0 : ((y<0) ? height : y);
    
    highlight = false;
    collided = false;
  }

  void setHighlight(boolean value) {
    this.highlight = value;
  }

  void show() {
    noStroke();
    if (highlight && collided) fill(0,0,255);
    else if (highlight) fill(0,255,0);
    else if (collided) fill(255,0,0);
    else fill(255);
    ellipse(x,y,dim,dim);
  }
}
