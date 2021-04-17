class Hud {
	int stage;
	int enemies;
	int life;
	int score;

	Hud() {
		this.stage = 1;
		this.enemies = 1;
		this.life = ACTOR_LIFE;
		this.score = 0;
	}

	void setStage(int n) { this.stage = n; }
	void setEnemies(int n) { this.enemies = n; }
	void setLife(int n) { this.life = n; }

	void updateScore(int n) { this.score += n; }

	int getScore() { return this.score; }

	void display() {
		pushStyle();
		fill(HUD_COLOR);
		textSize(HUD_TEXT_SIZE);
		text(life, HUD_LEFT_MARGIN, HUD_TOP_MARGIN + HUD_TEXT_SIZE);
		text(stage, HUD_LEFT_MARGIN, height - HUD_BOTTOM_MARGIN);
		text(score, width - HUD_RIGHT_MARGIN, HUD_TOP_MARGIN + HUD_TEXT_SIZE);
		text(enemies, width - HUD_RIGHT_MARGIN, height - HUD_BOTTOM_MARGIN);
		popStyle();
	}
}	
