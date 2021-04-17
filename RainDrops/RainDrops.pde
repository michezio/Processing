final float SPEED = 3;
final float RADIUS_INCREMENT = 0.9;
final float MAX_RADIUS = 100;

ArrayList<Drop> rain;

void setup() {
	size(500,400);
	colorMode(HSB);
	rain = new ArrayList<Drop>();
}

void draw() {
	background(0);
	for (int i = rain.size()-1; i>=0; --i) {
    Drop D = rain.get(i);
		D.update();
		D.display();
		if (D.isOut()) rain.remove(i);
	}
  if (random(1) > 0.90) rain.add(new Drop());
}

class Drop {
	float x;
	float y;
	ArrayList<Circle> circ;
	color c;
  float v;

	Drop() {
		this.x = random(width);
		this.y = -10;
    this.v = random(1,SPEED);
		circ = new ArrayList<Circle>();
		c = color(random(255));
	}

	void update() {
		this.y += v;
		if (random(1) > 0.98)
			circ.add(new Circle(x,y,c));
		for (int i = circ.size()-1; i>=0; --i) {
      Circle C = circ.get(i);
			C.update();
      if (C.isOut()) circ.remove(C);
		}
	}

	void display() {
		noStroke();
		fill(c);
		ellipse(x, y, 10, 10);
    for (Circle C : circ) C.display();
	}

  boolean isOut() {
    return (y > height + MAX_RADIUS*SPEED + MAX_RADIUS);
  }
}

class Circle {
	float x;
	float y;
	float r;
	color c;

	Circle(float x, float y, color c) {
		this.x = x;
		this.y = y;
		this.c = c;
		this.r = 0;
	}

	void update() {
		r += RADIUS_INCREMENT;
	}

	void display() {
		noFill();
		stroke(c, map(r, 0, MAX_RADIUS, 255, 0));
    ellipse(x, y, r, r);
	}

	boolean isOut() {
		return (r > MAX_RADIUS);
	}
}