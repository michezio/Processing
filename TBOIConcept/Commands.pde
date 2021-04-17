class Commands {
	boolean moveUp, moveDown, moveLeft, moveRight;
	boolean shootUp, shootDown, shootLeft, shootRight;
	String move, shoot;

	Commands(String move, String shoot) {
		moveUp = moveDown = moveLeft = moveRight = false;
		shootUp = shootDown = shootLeft = shootRight = false;

		if (move.length() == 4) this.move = move;
		else this.move = "wasd";
		if (shoot.length() == 4) this.shoot = shoot;
		else this.shoot = "ijkl";
	}

	char getKey(String key) {
		key = key.toLowerCase();
		char toReturn = ' ';
		switch (key) {
			case "moveup": toReturn = this.move.charAt(0); break;
			case "moveleft": toReturn = this.move.charAt(1); break;
			case "movedown": toReturn = this.move.charAt(2); break;
			case "moveright": toReturn = this.move.charAt(3); break;
			case "shootup": toReturn = this.shoot.charAt(0); break;
			case "shootleft": toReturn = this.shoot.charAt(1); break;
			case "shootdown": toReturn = this.shoot.charAt(2); break;
			case "shootright": toReturn = this.shoot.charAt(3); break;
		}
		return toReturn;
	}
}

// INTERRUPTS

void keyPressed() {
		if (key == cmd.getKey("moveup")) cmd.moveUp = true;
		if (key == cmd.getKey("movedown")) cmd.moveDown = true;
		if (key == cmd.getKey("moveleft")) cmd.moveLeft = true;
		if (key == cmd.getKey("moveright")) cmd.moveRight = true;
		if (key == cmd.getKey("shootup")) cmd.shootUp = true;
		if (key == cmd.getKey("shootdown")) cmd.shootDown = true;
		if (key == cmd.getKey("shootleft")) cmd.shootLeft = true;
		if (key == cmd.getKey("shootright")) cmd.shootRight = true;
}

void keyReleased() {
		if (key == cmd.getKey("moveup")) cmd.moveUp = false;
		if (key == cmd.getKey("movedown")) cmd.moveDown = false;
		if (key == cmd.getKey("moveleft")) cmd.moveLeft = false;
		if (key == cmd.getKey("moveright")) cmd.moveRight = false;
		if (key == cmd.getKey("shootup")) cmd.shootUp = false;
		if (key == cmd.getKey("shootdown")) cmd.shootDown = false;
		if (key == cmd.getKey("shootleft")) cmd.shootLeft = false;
		if (key == cmd.getKey("shootright")) cmd.shootRight = false;
}
