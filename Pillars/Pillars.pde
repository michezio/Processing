final int PILLARS = 40;
final int SPACE = 0;
final int HEIGHT = 100;
final int DIVERGENCE = 50;
final int YPOS = 200;
final int RANDOMNESS = 50;

Pillar[] p;

void setup() {
  size(1000,600);
  p = new Pillar[PILLARS];
  float size = ((width - SPACE) / (float)PILLARS) - SPACE;
  float len = (HEIGHT * (height-YPOS-DIVERGENCE)/100.0);
  float offset = RANDOMNESS * YPOS / 100.0;
  for (int i=0; i<PILLARS; ++i) {
    p[i] = new Pillar(SPACE + i*(SPACE+size), YPOS - random(offset), size, random(len/5, len), DIVERGENCE);
  }
  
  //p[(int)random(PILLARS)].setColor(color(255,50,0));
}

void draw() {
  background(0);
  for (Pillar P : p) 
    P.show();
}


class Pillar {
  float x, y, w;
  PVector[] points;
  color col;
  
  Pillar(float x, float y, float w, float h, float div) {
    points = new PVector[4];
    points[0] = new PVector(x, y);
    points[1] = new PVector(x+w, y);
    points[2] = new PVector(x+w, y+h+random(div));
    points[3] = new PVector(x, y+h+random(div));
    col = color(255, 255, 255, 0);
  }
  
  void setColor(color c) { col = c; }
 
  void show() {
    pushStyle();
    stroke(red(col), green(col), blue(col));
    strokeWeight(2);
    fill(col);
    beginShape();
    for (int i=0; i<4; ++i)
      vertex(points[i].x, points[i].y);
    endShape(CLOSE);
    popStyle();
  }
}
