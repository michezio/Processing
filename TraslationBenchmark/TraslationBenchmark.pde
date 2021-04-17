final int BENCH_DIMENSION = 5000;
final boolean TRANSLATED = true;

/* 
  RESULTS:
  Adding a translation matrix to each element slightly increases computation time.
  For 5000 elements on my testing machine it renders in 9.67 FPS for
  non translated elements, and 9.32 FPS for translated ones.
*/

Ball[] b;

void setup() {
	size(400,400);
	colorMode(HSB);

	b = new Ball[BENCH_DIMENSION];

	for (int i=0; i<BENCH_DIMENSION; ++i) {
		if (TRANSLATED) b[i] = new TranslatedBall();
		else b[i] = new PositionalBall();
	}
}

void draw() {
  background(0);
	for (Ball B : b) {
		B.update();
		B.display();
	}

	if (frameCount % 60 == 0) {
		if (TRANSLATED) println("TranslatedBall FPS for " + BENCH_DIMENSION + " elements: " + frameRate + " fps");
		else println("PositionalBall FPS for " + BENCH_DIMENSION + " elements: " + frameRate + " fps");
	}
}


abstract class Ball {
	PVector pos;
	PVector vel;
	float dim;
	color col;

	Ball() {
		pos = new PVector(random(width), random(height));
		vel = new PVector(random(-2, 2), random(-2, 2));
		dim = 20;
		col = color(random(255), 255, 255);
	}

  abstract void display();

	void update() {
		pos.add(vel);
		if (pos.x > width) {
			pos.x = width;
			vel.x *= -1;
		}
		if (pos.x < 0) {
			pos.x = 0;
			vel.x *= -1;
		}
		if (pos.y > height) {
			pos.y = height;
			vel.y *= -1;
		}
		if (pos.y < 0) {
			pos.y = 0;
			vel.y *= -1;
		}
	}
}

class TranslatedBall extends Ball {
	void display() {
		pushStyle();
		pushMatrix();
		noStroke();
		fill(col);
		translate(pos.x, pos.y);
		ellipse(0, 0, dim, dim);
		popMatrix();
		popStyle();
	}
}

class PositionalBall extends Ball {
	void display() {
		pushStyle();
		noStroke();
		fill(col);
		ellipse(pos.x, pos.y, dim, dim);
		popStyle();
	}
}
