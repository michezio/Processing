class Leaf {
  PVector[] c1, c2;
  
  Leaf(PVector origin, PVector end, PVector cp1, PVector cp2) {
    this.c1 = new PVector[4];
    this.c2 = new PVector[4];
    c1[0] = c2[0] = origin;
    c1[3] = c2[3] = end;
    c1[1] = c1[2] = cp1;
    c2[1] = c2[2] = cp2;
  }
  
  float length() {
    return dist(c1[0].x, c1[0].y, c1[3].x, c1[3].y);
  }
  
  void fillLine(float step) {
    float incr = step/length();
    for (float i=0; i<1; i+=incr) {
      PVector p1 = bezierPointArray(c1, i);
      PVector p2 = bezierPointArray(c2, i);
      line(p1, p2);
    }
  }
  
  PVector bezierPointArray(PVector[] c, float t) {
    float x = bezierPoint(c[0].x, c[1].x, c[2].x, c[3].x, t);
    float y = bezierPoint(c[0].y, c[1].y, c[2].y, c[3].y, t);
    return new PVector(x, y);
  }
  
  void testShow() {
    bezier(c1[0].x, c1[0].y, c1[1].x, c1[1].y, c1[2].x, c1[2].y, c1[3].x, c1[3].y);
    bezier(c2[0].x, c2[0].y, c2[1].x, c2[1].y, c2[2].x, c2[2].y, c2[3].x, c2[3].y);
  }
  
}
