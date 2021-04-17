class RandomShape
{
  private PVector pos;
  private PVector vel;
  private int sides;
  private float angle;
  private PVector[] points;
  private float rotation;
  private float phase;
  private color col;
  private float radius;
  private float damp = 0.999;
  
  RandomShape(int x, int y, float v, int s, float r, color c)
  {
    pos = new PVector(x,y);
    vel = new PVector(random(v),0);
    vel.rotate(random(TWO_PI));
    sides = s;
    angle = TWO_PI/sides;
    points = new PVector[sides];
    rotation = random(-TWO_PI/60.0,TWO_PI/60.0);
    col = c;
    radius = random(r/5,r);
    for (int i=0; i<sides; ++i)
    {
      points[i] = new PVector(noise(i+radius)*radius,0);
      points[i].rotate(angle*i);
    }
    phase = random(TWO_PI);
  }
  
  void show()
  {
    pushMatrix();
    //stroke(col);
    //noFill();
    noStroke();
    fill(col);
    translate(pos.x, pos.y);
    rotate(phase);
    beginShape();
      for (int i=0; i<sides; ++i)
        vertex(points[i].x, points[i].y);
    endShape(CLOSE);
    popMatrix();
  }
  
  void update()
  {
    phase += rotation;
    rotation *= damp;
    pos.add(vel);
    vel.mult(damp);
    
    if (pos.x > width + radius) pos.x = -radius;
    else if (pos.x < -radius) pos.x = width + radius;
    if (pos.y > height + radius) pos.y = -radius;
    else if (pos.y < -radius) pos.y = height + radius;
  }
}
