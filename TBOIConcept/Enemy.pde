class Enemy {
	PVector pos;
	PVector vel;
	PVector dim;
	int life;
	float size;
	int damage;

	Enemy(float x, float y) {
		this.pos = new PVector(x, y);
		this.vel = new PVector(0,ENEMY_SPEED);
		vel.rotate(random(TWO_PI));
		this.life = ENEMY_LIFE;
		this.size = ENEMY_SIZE;
		this.damage = ENEMY_DAMAGE;
	}

	void update() {
		pos.add(vel);
		if (pos.x > width-size*0.5) {
			pos.x = width-size*0.5;
			vel.x *= -1;
		}
		else if (pos.x < size*0.5) {
			pos.x = size;
			vel.x *= -1;
		}
		if (pos.y > height-size*0.5) {
			pos.y = height-size*0.5;
			vel.y *= -1;
		}
		else if (pos.y < size*0.5) {
			pos.y = size*0.5;
			vel.y *= -1;
		}
	}

	void display() {
		pushStyle();
		noStroke();
		fill(ENEMY_COLOR);
		ellipse(pos.x, pos.y, size, size);
		fill(0);
		text(life, pos.x, pos.y);
		popStyle();
	}

	void applyModifier(Actor act) {
		act.life -= damage;
	}
}
