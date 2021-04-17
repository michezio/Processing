Commands cmd; 
Actor act;
Hud hud;
ArrayList<Enemy> enm;
ArrayList<Pickup> pik;

int stage;

void setup() {
	size(800,600);
	cmd = new Commands("wasd", "ijkl");
	act = new Actor();
	stage = 1;
	generateEnemies(stage);
	pik = new ArrayList<Pickup>();
	hud = new Hud();
}

void draw() {
	background(BKG_COLOR);
	act.executeCommands(cmd);
	act.update();

	checkCollisions();

	for (Pickup P : pik) {
		P.display();
	}
	for (Enemy E : enm) {
		E.update();
		E.display();
	}
	act.display();

	if (act.life <= 0) restartGame();
	if (enm.size() == 0) nextStage();
	
	updateShowHUD();
}

void updateShowHUD() {
	hud.setStage(stage);
	hud.setEnemies(enm.size());
	hud.setLife(act.life);
	hud.display();
}

void generateEnemies(int stage) {
	enm = new ArrayList<Enemy>(stage);
	for (int i=0; i<stage; ++i) {
		enm.add(new Enemy(random(width), random(height)));
	}
}

void checkCollisions() {
	for (int i=pik.size(); --i >= 0;) {
		Pickup p = pik.get(i);
		if (sqDist(p.pos, act.pos) < sqSize(p.size+act.size)) {
			p.applyModifier(act);
			pik.remove(i);
		}
	}
	for (int i=enm.size(); --i >= 0;) {
		Enemy e = enm.get(i);
		for (int j=act.proj.size(); --j >= 0;) {
			Projectile p = act.proj.get(j);
			if (sqDist(e.pos, p.pos) < sqSize(e.size+p.size)) {
				p.applyModifier(e);
				act.proj.remove(j);
			}
		}
	for (int j=pik.size(); --j >= 0;) {
		Pickup p = pik.get(j);
		if (sqDist(e.pos, p.pos) < sqSize(e.size+p.size)) {
			p.applyModifier(e);
			pik.remove(j);
		}
	}
		if (e.life <= 0) removeEnemy(i);
		if (act.invuln <= 0) act.checkEnemy(e);
	}
}

void restartGame() {
	stage = 1;
	act = new Actor();
	generateEnemies(stage);
	pik.clear();
}

void nextStage() {
	generateEnemies(++stage);
	act.invuln = ACTOR_INV_TIME;
}

void removeEnemy(int i) {
	if (random(1) < PICKUP_CHANCE) pik.add(createPickup(enm.get(i).pos));
	enm.remove(i);
}
