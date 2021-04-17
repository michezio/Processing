PVector[] p;
final float pts = 1000;
final int CURVEPTS = 30;

void setup() {
  frameRate(1000);
  size(600,600);
  p = new PVector[CURVEPTS+3];
  
  for (int i=0; i<CURVEPTS; ++i) {
    p[i] = new PVector(150, 0);
    p[i].rotate(i*TWO_PI/(CURVEPTS));
  }
  p[CURVEPTS] = p[0].copy();
  p[CURVEPTS+1] = p[1].copy();
  p[CURVEPTS+2] = p[1].copy();
  
  background(0);
}

void draw() {
  translate(width/2, height/2);
  for (int i=0; i<CURVEPTS; ++i) {
    p[i].add(random(-1, 1), random(-1, 1));
    p[i].mult(1.00005);
  }
  p[CURVEPTS] = p[0].copy();
  p[CURVEPTS+1] = p[1].copy();
  p[CURVEPTS+2] = p[1].copy();
  
  //background(0);
  stroke(255, 5);
  sandSpline(p, (int)pts);
  //println(frameRate);
  //if (frameCount == 60*200) {
  //  noLoop();
  //  saveFrame("FurryBezier.png");
  //  println("SAVED");
  //}
}
