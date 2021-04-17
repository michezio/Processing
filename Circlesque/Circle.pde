class Circle {

	PVector pos;
	int r;
	color[] c;
  float angle;
	float incr;
	float dim;
  Palette p;

	Circle(float x, float y, float dim, int num, Palette p) {
		this.pos = new PVector(x,y);
		r = ceil(random(num));
		c = new color[r];
		for (int i=0; i<r; ++i) {
			c[i] = p.getColor();
		}
    angle = 0;
		this.dim = random(dim/5.0,dim);
		incr = random(0.2);
	}

	void update() {
	  angle += incr;
	}

	void display() {
		noStroke();
    float s = dim/r;
		for (int i=r-1; i>=0; --i) {
      float rad = s*(i+1+sin(angle)*RANGE-RANGE);
			fill(c[i]);
			ellipse(pos.x, pos.y, rad, rad);
		}
	}
}
