PVector p1, p2;
PVector v1, v2;
float pts;

void setup() {
  frameRate(1000);
  size(400,400,P2D);
  p1 = new PVector(0,0);
  p2 = new PVector(0,height);
  v1 = new PVector(0.1, 0);
  v2 = new PVector(0.1, 0);
  background(0);
  pts = height;
}

void draw() {
  //background(0);
  stroke(255,50);
  sandLine(p1, p2, round(pts));
  pts -= 0.1;
  p1.add(v1);
  p2.add(v2);
  if (p1.x > width) noLoop();
  println(frameRate);
}
