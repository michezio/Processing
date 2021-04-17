//Zigzag z;

Leaf f;

void setup() {
  size(500,500,P2D);
  f = new Leaf( new PVector(100,100),
                new PVector(300,400),
                new PVector(200, 150),
                new PVector(150, 300) );
  //z = new Zigzag(new PVector(10,10), 200, 0, width-20, height-20);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  f.testShow();
  f.fillLine(20);
  //z.show();
}

void line(PVector a, PVector b) {
  line(a.x, a.y, b.x, b.y);
}


class Zigzag {
  ArrayList<PVector> zig;
  float angle;
  float step;
  int pts;
  float w, h;
  PVector origin;
  
  Zigzag(PVector origin, int pts, float angle, float w, float h) {
    this.origin = origin;
    this.pts = pts;
    this.angle = angle;
    this.w = w;
    this.h = 1.5*h;
    this.step = 2*this.h/pts;
    zig = new ArrayList<PVector>();
    build();
  }
  
  void build() {
    zig.add(origin);
    PVector p = origin.copy();
    for (int i=1; i<pts; ++i) {
      switch (i % 4) {
        case 1:
          p = linear(p, w, angle);
          break;
        case 0:
        case 2:
          p.add(0, step*parabolic(i, pts));
          //p.add(0, step);
          break;
        case 3:
          p = linear(p, -w, angle);
          break;          
      }
      zig.add(p.copy());
    }
  }
  
  void show() {
    pushStyle();
    stroke(255);
    noFill();
    beginShape();
    for (PVector P : zig) {
      vertex(P.x, P.y);
    }
    endShape();
    popStyle();
  }  
  
  PVector linear(PVector A, float offset, float angle) {
    if (angle == HALF_PI || angle == 3*HALF_PI) {
      println("ERROR: linear undefined for 90° angles, returning unchanged...");
      return A;
    }
    
    return new PVector(A.x + offset, tan(angle)*offset + A.y);
  }
  
  float parabolic(float x, float range) {
    float c = range/2.0;
    float a = -pow(c, -2);
    return a*pow(x-c, 2) + 1;
  }
}
