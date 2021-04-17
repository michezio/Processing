void sandLine(PVector a, PVector b, int pts) { 
  for (int i=0; i<pts; ++i) {
    float t = random(1);
    float x = t*(b.x-a.x) + a.x;
    float y = t*(b.y-a.y) + a.y;
    point(x, y);
  }
}

void sandLineLinear(PVector a, PVector b, int pts) {
  float step = 1.0/pts;
  for (int i=0; i<pts; ++i) {
    float t = i*step;
    float x = t*(b.x-a.x) + a.x;
    float y = t*(b.y-a.y) + a.y;
    point(x, y);
  }
}
