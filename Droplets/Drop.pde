final float SIZE = 0.5;
final float SPEED = 0.3;
final float DAMP = 0.92;

class Drop {
	float x;
	float y;
	float finalR;
  float curntR;
	private float size;
	private float speed;
	private float damp;
	private float t;
	boolean active;

	Drop(float x, float y, float r, float size, float speed, float damp) {
		this.x = x;
		this.y = y;
		this.finalR = r;
		this.curntR = 0;
		this.size = finalR*size;
		this.speed = speed;
		this.damp = damp;
		this.active = true;
		this.t = 0;
	}

	Drop(float x, float y, float r) {
		this(x, y, r, SIZE, SPEED, DAMP);
	}

	void update() {
		if (!active) return;

		curntR = finalR - size*cos(t);
		t += speed;
		size *= damp;

		if (size < 0.1) active = false;
	}

	void show(color c) {
		pushStyle();
		noStroke();
		fill(c);
    if (active) fill(255,0,0);
		ellipse(x, y, curntR, curntR);
		popStyle();
	}
}