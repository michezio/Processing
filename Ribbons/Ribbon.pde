/*
Ribbons - Live Wallpaper
Based on KnotsAndRibbons by myself
Michele Abruzzese (@michezio) - 11/2020
*/

final float SPEED = 20.0;
final float ANGLE = 2.2;
final int SIZE = 500;
final int CHANGE = 10;
final float DIM = 5;
final float SMOOTH = 0.015;
final color BKCOL = color(0);
final float SWEEP = 0.3;

float rotor = TWO_PI/(ANGLE*CHANGE);
Ribbon ribbon;

void setup()
{
  fullScreen(OPENGL);
  frameRate(30);
  colorMode(HSB);
	 ribbon = new Ribbon(SIZE, rotor);
}

void draw()
{
	background(BKCOL);

  ribbon.update();
  PVector center = ribbon.getSmoothCenter(SMOOTH);
  translate(-center.x + width/2, -center.y + height/2);
  ribbon.show(DIM);

	if (frameCount%CHANGE == 0)
    ribbon.changeRotation();
}

class Ribbon
{
	ArrayList<PVector> points;
	PVector direction;
  PVector centroid;
	float rotation;
	int size;
  float col;
  float rotor;

	Ribbon(int s, float r)
	{
		size = s;
    col = 0;
    rotor = r;
		points = new ArrayList<PVector>(size);
		direction = new PVector(0,-SPEED);
    direction.rotate(random(TWO_PI));
		changeRotation();
		points.add(new PVector(0,0));
    centroid = new PVector(0,0);
	}

  void show(float st)
  {
    strokeWeight(st);
    stroke(round(col), 80, 255);
    noFill();
    beginShape();
      for (int i=0; i<points.size(); ++i)
        curveVertex(points.get(i).x, points.get(i).y);
    endShape();
  }

	void update()
  {
		direction.rotate(rotation);
		PVector n = getLast().copy();
		n.add(direction);
		points.add(n);
		if (points.size() >= size) points.remove(0);
  col += SWEEP;
  if (col > 255) col = 0;
	}

	void changeRotation() { rotation = random(-rotor,rotor); }

  PVector getLast() { return points.get(points.size()-1); }
  PVector getPoint(int i) { return points.get((i >= 0) ? i : points.size() - i); }
  
  PVector getSmoothCenter(float ratio)
  {
    PVector last = getLast().copy();
    last.mult(ratio);
    centroid.mult(1 - ratio);
    centroid.add(last);
    return centroid;
  }
}