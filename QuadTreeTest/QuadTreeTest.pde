// Processing Test module

final int MAXSIZE = 1000;

class Point extends qtElement {
	float dim;

	Point(float x, float y) {
		super(x, y);
		this.dim = 2;
	}

	void show() {
		noStroke();
		fill(0,255,0);
		ellipse(x,y,dim,dim);
	}
}

QuadTree qt;
ArrayList<Point> pts;

void setup() {
	size(500,500);
	qt = new QuadTree(width, height, 3);
	pts = new ArrayList<Point>(MAXSIZE+1);
}

void draw() {
  background(255);
	qt = new QuadTree(width, height, 3);
	for (Point p : pts) {
		qt.insert(p);
		p.show();
	}

	qt.show();
}

void mouseDragged() {
	pts.add(new Point(mouseX + random(-50,50), mouseY + random(-50,50)));
  if (pts.size() > MAXSIZE) pts.remove(0);
}