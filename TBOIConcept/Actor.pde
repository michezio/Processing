class Actor {
	PVector pos;
	PVector vel;
	ArrayList<Projectile> proj;
	int shootWait;
	int p_rate;
	float p_size;
	float p_speed;
	float p_damage;
	float size;
	float speed;
	int life;
	int invuln;

	Actor() {
		this.pos = new PVector(width/2, height/2);
		this.vel = new PVector(0,0);
		this.proj = new ArrayList<Projectile>();
		this.shootWait = 0;
		this.p_rate = PROJ_RATE;
		this.p_size = PROJ_SIZE;
		this.p_damage = PROJ_DAMAGE;
		this.p_speed = PROJ_SPEED;
		this.size = ACTOR_SIZE;
		this.speed = ACTOR_SPEED;
		this.invuln = ACTOR_INV_TIME;
		this.life = ACTOR_LIFE;
	}

	void executeCommands(Commands cmd) {
		vel.set(0,0);
		if (cmd.moveUp) vel.add(0, -speed);
		if (cmd.moveDown) vel.add(0, speed);
		if (cmd.moveLeft) vel.add(-speed, 0);
		if (cmd.moveRight) vel.add(speed, 0);

		if (cmd.shootUp) shoot(0, -1);
		else if (cmd.shootDown) shoot(0, 1);
		else if (cmd.shootLeft) shoot(-1, 0);
		else if (cmd.shootRight) shoot(1, 0);
		else shoot(0, 0);
	}

	void shoot(int x, int y) {
		if (shootWait-- <= 0) {
			if (x != y) {
				proj.add(new Projectile(this.pos, x, y, p_speed, p_size, p_damage));
				shootWait = p_rate;
			}
			else {
				shootWait = 0;
			}
		}
	}

	void update() {
		pos.add(vel);
		if (pos.x > width-size*0.5) pos.x = width-size*0.5;
		else if (pos.x < size*0.5) pos.x = size*0.5;
		if (pos.y > height-size*0.5) pos.y = height-size*0.5;
		else if (pos.y < size*0.5) pos.y = size*0.5;
		for (int i=proj.size(); --i >= 0;) {
			if (proj.get(i).update() == true) proj.remove(i);
		}
		--invuln;
	} 

	void display() {
		pushStyle();
		for (Projectile P : proj) P.display();
		noStroke();
		fill(ACTOR_COLOR, (invuln > 0) ? 128 : 255);
		ellipse(pos.x, pos.y, size, size);
		popStyle();
	}

	void checkEnemy(Enemy en) {
		if (sqDist(this.pos, en.pos) < sqSize(size+en.size)) {
			en.applyModifier(this);
			invuln = ACTOR_INV_TIME;
		}
	}
}
