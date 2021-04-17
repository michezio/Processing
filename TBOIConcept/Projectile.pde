class Projectile {
	PVector pos;
	PVector vel;
	float speed;
	float size;
	float damage;
	float range;

	Projectile(PVector pos, int x, int y, float speed, float size, float damage) {
		this.speed = speed;
		this.size = size;
		this.damage = damage;
		this.pos = pos.copy();
		this.vel = new PVector(x, y);
		this.vel.mult(speed);
	}

	boolean update() {
		this.pos.add(this.vel);

		if (pos.x > width+size || pos.x < -size || pos.y > height+size || pos.y < -size)
			return true;
		
		return false;
	}

	void display() {
		pushStyle();
		stroke(0);
		strokeWeight(2);
		fill(PROJ_COLOR);
		ellipse(pos.x, pos.y, size, size);
		popStyle();
	}

	void applyModifier(Enemy enm) {
		enm.life -= damage;
	}
}