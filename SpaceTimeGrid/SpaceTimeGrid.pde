final float SPACE = 10;
final float AMOUNT = 1000;
final float LIMIT = 200;
int X_GRID, Y_GRID;

Point[][] p;

void setup() {
	size(500,500);
	X_GRID = ceil(width/SPACE)+1;
	Y_GRID = ceil(height/SPACE)+1;
	p = new Point[Y_GRID][];
	for (int i=0; i<Y_GRID; ++i) {
		p[i] = new Point[X_GRID];
		for (int j=0; j<X_GRID; ++j) {
			p[i][j] = new Point(j*SPACE, i*SPACE);
		}
	}
	background(0);
}

void draw() {
	background(0);
	strokeWeight(1);
	stroke(100,200,255,100);
  noFill();
	drawGrid();
}

void drawGrid() {
  for (int i=Y_GRID; --i>=0;) {
    beginShape();
    for (int j=X_GRID; --j>=0;) {
      p[i][j].update(mouseX, mouseY);
      if (j == X_GRID-1 || j == 0)
        curveVertex(p[i][j].getX(), p[i][j].getY());
      curveVertex(p[i][j].getX(), p[i][j].getY());
    }
    endShape();
  }
  for (int j=X_GRID; --j>=0;) {
    beginShape();
    for (int i=Y_GRID; --i>=0;) {
      if (i == Y_GRID-1 || i == 0)
        curveVertex(p[i][j].getX(), p[i][j].getY());
      curveVertex(p[i][j].getX(), p[i][j].getY());
    }
    endShape();
  }
}

class Point {
	PVector pos;
	PVector shift;

	Point(float x, float y) {
		this.pos = new PVector(x,y);
    this.shift = new PVector(0,0);
	}

	void update(float x, float y) {
		float d = dist(this.pos.x, this.pos.y, x, y);
		shift.set(this.pos.x - x, this.pos.y - y);
		shift.normalize();
		shift.mult(AMOUNT/d);
    shift.limit(LIMIT);
	}

	void display() {
		point(pos.x+shift.x, pos.y+shift.y);
	}

	float sqdist(float x1, float y1, float x2, float y2) {
		float dx = x1-x2;
		float dy = y1-y2;
		return dx*dx+dy*dy;
	}

  float getX() {
    return pos.x+shift.x;
  }
  
  float getY() {
    return pos.y+shift.y;
  }
}
