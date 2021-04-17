class Leaf {
  PVector[] c1, c2;
  float length;
  float width;
  float balance;
  boolean quadratic;
  
  Leaf(PVector origin, PVector end, PVector[] cp1, PVector[] cp2) {
    this.c1 = new PVector[4];
    this.c2 = new PVector[4];
    c1[0] = c2[0] = origin;
    c1[3] = c2[3] = end;
    c1[1] = cp1[0];
    c1[2] = cp1[1];
    c2[1] = cp2[0];
    c2[2] = cp2[1];
    this.length = dist(c1[0].x, c1[0].y, c1[3].x, c1[3].y);
    quadratic = false;
  }
  
  Leaf(PVector origin, PVector end, PVector cp1, PVector cp2) {
    this.c1 = new PVector[3];
    this.c2 = new PVector[3];
    c1[0] = c2[0] = origin;
    c1[2] = c2[2] = end;
    c1[1] = cp1;
    c2[1] = cp2;
    this.length = dist(c1[0].x, c1[0].y, c1[2].x, c1[2].y);
    quadratic = true;
  }
  
  Leaf(PVector origin, PVector end, float wid, float bal) {
    PVector[] cp = findControlPoints(origin, end, wid, bal);
    this.c1 = new PVector[3];
    this.c2 = new PVector[3];
    this.balance = bal;
    this.width = wid;
    c1[0] = c2[0] = origin;
    c1[1] = cp[0];
    c2[1] = cp[1];
    c1[2] = c2[2] = end;
    this.length = dist(c1[0].x, c1[0].y, c1[2].x, c1[2].y);
    quadratic = true;
  }
  
  Leaf(PVector origin, PVector end, float wid) {
    this(origin, end, wid, 0.5);
  }
  
  void setOrigin(PVector p) { 
    c1[0] = c2[0] = p;
  }
  void setEnd(PVector p) { 
    if (quadratic) c1[2] = c2[2] = p;
    else c1[3] = c2[3] = p;
  }
  void setControlPoints(PVector[] cp1, PVector[] cp2) {
    if (quadratic) {
      println("Leaf is not cubic, please use only 2 control points");
      return;
    }
    c1[1] = cp1[0];
    c1[2] = cp1[1];
    c2[1] = cp2[0];
    c2[2] = cp2[1];
  }
  void setControlPoints(PVector cp1, PVector cp2) {
    if (!quadratic) {
      c1[1] = c1[2] = cp1;
      c2[1] = c2[2] = cp2;
    }
    c1[1] = cp1;
    c2[1] = cp2;
  }
  void setWidth(float w) {
    if (!quadratic) {
      println("Leaf is cubic, width is not defined");
      return;
    }
    this.width = w;
    straighten();
  }
  
  void straighten() {
    if (!quadratic) {
      println("Leaf is cubic, please update control points manually");
      return;
    }
    PVector[] cp = findControlPoints(c1[0], c1[2], this.width, this.balance);
    c1[1] = cp[0];
    c2[1] = cp[1];
  }
  
  void fillLine(float pts) {
    float incr = 1.0/pts;
    for (float i=0; i<1; i+=incr) {
      PVector p1 = quadratic ? quadraticPoint(c1, i) : bezierPointArray(c1, i);
      PVector p2 = quadratic ? quadraticPoint(c2, i) : bezierPointArray(c2, i);
      line(p1.x, p1.y, p2.x, p2.y);
    }
  }
  
  void fillZigzag(float pts) {
    float incr = 1.0/pts;
    noFill();
    beginShape();
    float t = 0;
    PVector a = quadratic ? quadraticPoint(c1, 0) : bezierPointArray(c1, 0);
    for (int i=0; i<2*pts; ++i) {
      switch (i % 4) {
        case 0: 
          a = quadratic ? quadraticPoint(c1, t) : bezierPointArray(c1, t);
          t = t+incr;
          break;
        case 1:
          a = quadratic ? quadraticPoint(c1, t) : bezierPointArray(c1, t);
          break;
        case 2:
          a = quadratic ? quadraticPoint(c2, t) : bezierPointArray(c2, t);
          t = t+incr;
          break;
        case 3:
          a = quadratic ? quadraticPoint(c2, t) : bezierPointArray(c2, t);
          break;
      }
      vertex(a.x, a.y);
    }
    endShape();
  }
  
  void testShow() {
    if (quadratic) {
      quadraticBezier(c1[0].x, c1[0].y, c1[1].x, c1[1].y, c1[2].x, c1[2].y);
      quadraticBezier(c2[0].x, c2[0].y, c2[1].x, c2[1].y, c2[2].x, c2[2].y);
    }
    else {
      bezier(c1[0].x, c1[0].y, c1[1].x, c1[1].y, c1[2].x, c1[2].y, c1[3].x, c1[3].y);
      bezier(c2[0].x, c2[0].y, c2[1].x, c2[1].y, c2[2].x, c2[2].y, c2[3].x, c2[3].y);
    }
  }
  
  void quadraticBezier(float ax, float ay, float cx, float cy, float bx, float by) {
    beginShape();
    vertex(ax, ay);
    quadraticVertex(cx, cy, bx, by);
    endShape();
  }
  
  float quadraticPoint(float a, float b, float c, float t) {
    return (1-t)*(1-t)*a + 2*(1-t)*t*b + t*t*c;
  }
  
  PVector quadraticPoint(PVector[] c, float t) {
    float x = quadraticPoint(c[0].x, c[1].x, c[2].x, t);
    float y = quadraticPoint(c[0].y, c[1].y, c[2].y, t);
    return new PVector(x, y);
  }
  
  PVector bezierPointArray(PVector[] c, float t) {
    float x = bezierPoint(c[0].x, c[1].x, c[2].x, c[3].x, t);
    float y = bezierPoint(c[0].y, c[1].y, c[2].y, c[3].y, t);
    return new PVector(x, y);
  }
  
  PVector[] findControlPoints(PVector a, PVector b, float w, float bal) {
    PVector c = linePoint(a, b, bal);
    double m = -((double)b.x-a.x)/(b.y-a.y+EPSILON);
    double p = c.y - m*c.x;
    double root = sqrt((float)((w*w)/(1+m*m)));
    double x1 = c.x + root;
    double x2 = c.x - root;
    double y1 = m*x1 + p;
    double y2 = m*x2 + p;
    return new PVector[] { new PVector((float)x1, (float)y1), new PVector((float)x2, (float)y2) };
  }
  
  PVector linePoint(PVector a, PVector b, float t) {
    float x = t*(b.x-a.x) + a.x;
    float y = t*(b.y-a.y) + a.y;
    return new PVector(x, y);
  }
}
