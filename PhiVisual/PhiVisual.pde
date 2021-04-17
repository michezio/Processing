final int ELEMENTS = 500;
float angle = (1+sqrt(5))/2.0 - 1;

void setup() {
  size(500,500);
}

void draw() {
  background(0);
  angle = map(mouseX, 0, width, 0, 1);
  text(angle, 10, 30);
  translate(width/2, height/2);
  PVector p = new PVector(0,5);
  PVector incr = new PVector(0,0.5);
  for (int i=0; i<ELEMENTS; ++i) {
    noStroke();
    fill(255);
    ellipse(p.x, p.y, 2, 2);
    p.rotate(angle*TWO_PI);
    p.add(incr.rotate(angle*TWO_PI).mult(0.999));
  }
}
