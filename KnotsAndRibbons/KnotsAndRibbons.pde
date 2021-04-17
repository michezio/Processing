import processing.pdf.*;

// PARAMETERS

final int COUNT = 1;
final float SPEED = 1.0;
final float ANGLE = 1;
final int SIZE = 100000;
final int STEP = 10;
final int CHANGE = 60;
final float DIM = 1;
final color BKCOL = color(255,255,220);
final color COLOR = color(0);
final int MARGIN = 10;

Ribbon[] r;

boolean record = false;
boolean regular = false;
boolean realtime = true;
float rotor = TWO_PI/(ANGLE*CHANGE);

// SETUP

void setup()
{
	size(800,200);
  colorMode(HSB);
	r = new Ribbon[COUNT];
  r[0] = new Ribbon(SIZE, COLOR, rotor);
  for (int i=1; i<COUNT; ++i)
    r[i] = new Ribbon(SIZE, color(random(255),255,255,alpha(COLOR)), rotor);
}

// DRAW

void draw()
{
  if (record) beginRecord(PDF, "frame-####.pdf");
  
	background(BKCOL);
  
  float minX = r[0].minX;
  float maxX = r[0].maxX;
  float minY = r[0].minY;
  float maxY = r[0].maxY;
  for (int i=1; i<COUNT; ++i)
  {
    float minX_ = r[i].minX;
    float minY_ = r[i].minY;
    float maxX_ = r[i].maxX;
    float maxY_ = r[i].maxY;
    if (minX_ < minX) minX = minX_;
    if (maxX_ > maxX) maxX = maxX_;
    if (minY_ < minY) minY = minY_;
    if (maxY_ > maxY) maxY = maxY_;
  }
  PVector center = new PVector((minX+maxX)/2.0, (minY+maxY)/2.0);
  float scale = min((width-2*MARGIN)/abs(maxX-minX), (height-2*MARGIN)/abs(maxY-minY));
  
  translate(width/2 - scale*center.x ,height/2 - scale*center.y);
	for (int i=0; i<COUNT; ++i)
  {
    r[i].resetRange();
    if (realtime) r[i].update();
    else
    {
      for (int x=0; x<STEP; ++x)
      {
        for (int k=0; k<CHANGE; ++k) r[i].update();
        r[i].changeRotation();
      }
    }
    r[i].show(DIM, scale);
  }
  
  if (record) { endRecord(); record = false; }
  
	if (realtime && frameCount%CHANGE == 0)
  {
    for (int i=0; i<COUNT; ++i) r[i].changeRotation();
  }
  
  println(frameRate);
}

// INPUT

void keyPressed()
{
  if (key == ' ') record = true;
}


// CLASSES

class Ribbon
{
	ArrayList<PVector> points;
	PVector direction;
	float rotation;
	int size;
  float minX, minY, maxX, maxY;
  color col;
  float rotor;

	Ribbon(int s, color c, float r)
	{
		size = s;
    col = c;
    rotor = r;
		points = new ArrayList<PVector>(size);
		direction = new PVector(0,-SPEED);
    //direction.rotate(random(TWO_PI));
		changeRotation();
		points.add(new PVector(0,0));
    resetRange();
	}

  void show(float st, float s)
  {
    strokeWeight(st);
    stroke(col);
    noFill();
    beginShape();
      for (int i=0; i<points.size(); ++i)
      {
        checkRange(p(i));
        vertex(s*p(i).x, s*p(i).y);
      }
    endShape();
  }

	void update()
  {
		direction.rotate(rotation);
		PVector n = p(points.size()-1).copy();
		n.add(direction);
		points.add(n);

		if (points.size() >= size) points.remove(0);
	}

  void checkRange(PVector P)
  {
    if (P.x > maxX) maxX = P.x;
    else if (P.x < minX) minX = P.x;
    if (P.y > maxY) maxY = P.y;
    else if (P.y < minY) minY = P.y;
  }
  
  void resetRange()
  {
    minX = maxX = getLast().x;
    minY = maxY = getLast().y;
  }

	void changeRotation() { if (regular) rotation = random(1)>0.5 ? rotor : -rotor; else rotation = random(-rotor,rotor); }

	PVector p(int i) { return points.get(i); }

  PVector getLast() { return points.get(points.size()-1); }
  
  PVector getRange() { return new PVector(abs(maxX-minX), abs(maxY-minY)); }
  
  PVector getCentroid() { return new PVector((minX+maxX)/2.0, (minY+maxY)/2.0); }
}
