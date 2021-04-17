Leaf f;

PVector a, b;

void setup() {
  size(500,500,P2D);
  a = new PVector(random(width), random(height));
  b = new PVector(random(width), random(height));
  f = new Leaf(a, b, 60, 0.1);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  //f.testShow();
  b.set(mouseX, mouseY);
  f.straighten();
  f.fillZigzag(49);
  //f.quadraticBezier(100, 200, 200, 100, 300, 200);
  //line(200, 200, 200, 100);
}
