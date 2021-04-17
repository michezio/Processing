// MORPH BUBBLE ----------------------------------------------------------------------------

class MorphBubble2D {
  PVector pos;
  PVector vel;
  float size;
  float spread;
  float freq;
  float morph;
  color c;
  int points;
  float[] pts;
  
  MorphBubble2D(PVector pos, PVector vel, float size, int points) {
    this.pos = pos; 
    this.vel = vel;
    this.size = size;
    this.spread = size;
    this.freq = 2;
    this.morph = 0.03;
    this.c = color(70,20,255);
    this.points = points;
    pts = new float[points];
  }
  
  MorphBubble2D() {
    this(new PVector(random(width),random(height)), new PVector(random(-1,1),random(-1,1)), random(width/10,width/4), 20);
  }
  
  void update() {
    pos.add(vel);
    if (pos.x > width+size) pos.x = -size;
    else if (pos.x < -size) pos.x = width+size;
    if (pos.y > height+size) pos.y = -size;
    else if (pos.y < -size) pos.y = height+size;
    
    for (int i=0; i<points-1; ++i) {
      pts[i] = size+spread*(noise(pos.x*morph,pos.y*morph,i*freq)-0.5);
    }
    pts[points-1] = (pts[0]+pts[points-2])/2.0;
  }
  
  void show() {
    PVector p = new PVector(0,0);
    float a = TWO_PI/points;
    noFill();
    stroke(255);
    strokeWeight(10);
    beginShape();
    for (int i=0; i<points; ++i) {
      p.set(pts[i],0);
      p.rotate(i*a);
      p.add(pos);
      curveVertex(p.x,p.y);
    }
    for (int j=0; j<3; ++j) {
      p.set(pts[j],0);
      p.rotate(j*a);
      p.add(pos);
      curveVertex(p.x,p.y);
    }
    endShape(CLOSE);
  }
}
