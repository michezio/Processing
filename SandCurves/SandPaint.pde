void sandLine(PVector a, PVector b, int pts) { 
  for (int i=0; i<pts; ++i) {
    float t = random(1);
    float x = t*(b.x-a.x) + a.x;
    float y = t*(b.y-a.y) + a.y;
    point(x, y);
  }
}

void sandLine(PVector[] p, int pts) {
  for (int i=0; i<pts; ++i) {
    int n = floor(random(p.length - 1));
    float t = random(1);
    float x = t*(p[n+1].x-p[n].x) + p[n].x;
    float y = t*(p[n+1].y-p[n].y) + p[n].y;
    point(x, y);
  }
}

void sandSpline(PVector a, PVector b, PVector c, PVector d, int pts) { 
  for (int i=0; i<pts; ++i) {
    float t = random(1);
    float x = curvePoint(a.x, b.x, c.x, d.x, t);
    float y = curvePoint(a.y, b.y, c.y, d.y, t);
    point(x, y);
  }
}

void sandSpline(PVector[] p, int pts) {
  for (int i=0; i<pts; ++i) {
    int n = floor(random(p.length - 3));
    float t = random(1);
    float x = curvePoint(p[n].x, p[n+1].x, p[n+2].x, p[n+3].x, t);
    float y = curvePoint(p[n].y, p[n+1].y, p[n+2].y, p[n+3].y, t);
    point(x, y);
  }
}

void sandBezier(PVector a, PVector b, PVector c, PVector d, int pts) {
  for (int i=0; i<pts; ++i) {
    float t = random(1);
    float x = bezierPoint(a.x, b.x, c.x, d.x, t);
    float y = bezierPoint(a.y, b.y, c.y, d.y, t);
    point(x, y);
  }
}

void sandBezier(PVector[] p, int pts) {
  for (int i=0; i<pts; ++i) {
    int n = floor(random(p.length - 3));
    float t = random(1);
    float x = bezierPoint(p[n].x, p[n+1].x, p[n+2].x, p[n+3].x, t);
    float y = bezierPoint(p[n].y, p[n+1].y, p[n+2].y, p[n+3].y, t);
    point(x, y);
  }
}
