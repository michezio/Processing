final int SIZE = 20;
final float BOUNCE = 0.5;
final int MAX_LIST_SIZE = 5;
final float SCALE = 0.03;
final float PRECISION = SIZE*SIZE/4+100;
final float MAX_SPEED = 10;

import java.util.LinkedList;

LinkedList<PVector> points, dense;

boolean active;

ArrayList<Ball> p;

void setup() {
  size(500,500);
  points = new LinkedList<PVector>();
  dense = new LinkedList<PVector>();
  p = new ArrayList<Ball>();
  for (int i=0; i<300; i++) p.add(new Ball());
  active = false;
}

void draw() {
  background(0);
  PVector force = new PVector(0,0);
  
  if (active) {
    points.add(new PVector(mouseX, mouseY));
    if (points.size() > MAX_LIST_SIZE) points.remove(0);
  }
  else points.clear();
  
  for (int i=1; i<points.size(); ++i) {
    PVector gap = calculateForce(points.get(i), points.get(i-1));
    if (sqMag(gap) > sqMag(force)) {
      force = gap.copy();
    }
  }
  
  int siz = points.size();
  dense.clear();
  for (int i=1; i<siz; ++i) {
    PVector p1 = points.get(i);
    PVector p2 = points.get(i-1);
    dense.add(p2);
    dense.add(new PVector((p1.x+p1.x+p2.x)/3.0, (p1.y+p1.y+p2.y)/3.0));
    dense.add(new PVector((p1.x+p2.x+p2.x)/3.0, (p1.y+p2.y+p2.y)/3.0));
  }
  
  for (Ball B : p) {
    for (PVector P : dense) {
      if (sqDist(B.pos, P) < PRECISION) {
        B.vel.add(force);
        break;
      }
    }
    
    B.show();
  }
  
  for (PVector P : dense) {
    stroke(255,0,0);
    strokeWeight(2);
    point(P.x, P.y);
  }
}  

void mousePressed() {
  active = true;
}

void mouseReleased() {
  active = false;
}

float sqMag(PVector p) {
  return (p.x*p.x + p.y*p.y);
}

PVector calculateForce(PVector end, PVector start) {
  PVector v = new PVector(end.x - start.x, end.y - start.y);
  v.mult(SCALE);
  return v;
}

float sqDist(PVector p1, PVector p2) {
  float x = p1.x - p2.x;
  float y = p1.y - p2.y;
  return (x*x + y*y);
}

class Ball {
  PVector pos;
  PVector vel;
  
  Ball() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0,0);
  }
  
  void update() {
    pos.add(vel);
    
    if (pos.x > width) pos.x = width;
    else if (pos.x < 0) pos.x = 0;
    if (pos.y > height) pos.y = height;
    else if (pos.y < 0) pos.y = 0;
    
    if (pos.x == 0 || pos.x == width) vel.x *= -BOUNCE;
    if (pos.y == 0 || pos.y == height) vel.y *= -BOUNCE;
  }
  
  void show() {
    update();
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, SIZE, SIZE);
  }
}
