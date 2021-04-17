final String[] availPick = {
	"proj_rate", "proj_speed", "proj_size", "proj_damage",
	"act_agility", "act_fat", "act_lifedown"
};

abstract class Pickup {
	PVector pos;
	float stat;
	color col;
	float size;
	boolean negative;

	Pickup(PVector pos) {
		this.pos = pos;
		this.col = POSITIVE_COLOR;
		this.size = PICKUP_SIZE;
		this.negative = false;
	}

	void applyModifier(Actor act) {};

	void applyModifier(Enemy enm) {
		enm.life += ENEMY_LIFE_INCR;
		enm.vel.mult(ENEMY_SPEED_INCR);
	}
	
	void display() {
		pushStyle();
		stroke(0);
		fill(col);
		ellipse(pos.x, pos.y, size, size);
		popStyle();
	}
}

class PickupRate extends Pickup {
	PickupRate(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 10 : -10;
		this.negative = (stat > 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.p_rate += stat;
		if (act.p_rate < 10) act.p_rate = 10;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "FIRE RATE UP" : "FIRE RATE DOWN");
	}
}

class PickupSpeed extends Pickup {
	PickupSpeed(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 1 : -1;
		this.negative = (stat < 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.p_speed += stat;
		if (act.p_speed < 1) act.p_speed = 1;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "PROJECTILE SPEED DOWN" : "PROJECTILE SPEED UP");
	}
}

class PickupSize extends Pickup {
	PickupSize(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 5 : -5;
		this.negative = (stat < 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.p_size += stat;
		if (act.p_size < 5) act.p_size = 5;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "PROJECTILE SIZE DOWN" : "PROJECTILE SIZE UP");
	}
}

class PickupDamage extends Pickup {
	PickupDamage(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 1 : -1;
		this.negative = (stat < 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.p_damage += stat;
		if (act.p_damage < 1) act.p_damage = 1;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "PROJECTILE DAMAGE DOWN" : "PROJECTILE DAMAGE UP");
	}
}

class PickupAgility extends Pickup {
	PickupAgility(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 1 : -1;
		this.negative = (stat < 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.speed += stat;
		if (act.speed < 1) act.speed = 1;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "PLAYER SPEED DOWN" : "PLAYER SPEED UP");
	}
}

class PickupFat extends Pickup {
	PickupFat(PVector pos) {
		super(pos);
		this.stat = (random(1)>0.5) ? 10 : -10;
		this.negative = (stat > 0);
		this.col = (negative) ? NEGATIVE_COLOR : POSITIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.size += stat;
		if (act.size < 10) act.size = 10;
		if (negative && act.life < MAX_LIFE) act.life += 1;
		println((stat < 0) ? "PLAYER SIZE DOWN" : "PLAYER SIZE UP");
	}
}

class PickupLifedown extends Pickup {
	PickupLifedown(PVector pos) {
		super(pos);
		this.col = NEGATIVE_COLOR;
	}

	void applyModifier(Actor act) {
		act.life -= 1;
		println("LIFE DOWN");
	}
}

//////////////////////////////////////////////////////

Pickup createPickup(PVector pos) {
	Pickup p;
	int num = floor(random(availPick.length));
	String name = availPick[num];

	switch (name) {
		case "proj_rate": p = new PickupRate(pos); break;
		case "proj_speed": p = new PickupSpeed(pos); break;
		case "proj_size": p = new PickupSize(pos); break;
		case "proj_damage": p = new PickupDamage(pos); break;
		case "act_agility": p = new PickupAgility(pos); break;
		case "act_fat": p = new PickupFat(pos); break;
		case "act_lifedown": p = new PickupLifedown(pos); break;
		default: println("ERROR - Pickup not recognized"); p = null;
	}

	return p;
}
