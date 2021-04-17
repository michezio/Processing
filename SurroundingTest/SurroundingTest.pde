class Track {
	ArrayList<PVector> points;
	float left, right, top, bottom;
	static final float THRESHOLD = 10.0;

	Track(PVector start) {
    points = new ArrayList<PVector>();
		points.add(start);
		right = left = start.x;
		top = bottom = start.y;
	}

	void update(PVector new_point) {
		if (sqdist(points.get(points.size()-1), new_point) < THRESHOLD)
			return;
		points.add(new_point);
		if (new_point.x < left) left = new_point.x;
		else if (new_point.x > right) right = new_point.x;
		if (new_point.y < top) top = new_point.y;
		else if (new_point.y > bottom) bottom = new_point.y;
	}

	void render() {
		pushStyle();
		stroke(255,0,0);
		strokeWeight(2);
		noFill();
		beginShape();
		for (PVector p : points) {
			vertex(p.x, p.y);
		}
		endShape();
		popStyle();
	}
}

class Player {
	PVector pos;
	PVector vel;
	Track track;

	Player() {
		pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
		this.track = new Track(pos.copy());
	}

	void setVel(float x, float y) {
		vel.set(x, y);
	}

	void stop() {
		vel.set(0, 0);
	}

	void update() {
		 pos.add(vel);
		 track.update(pos.copy());
	}

  void renderTrack() {
    track.render();
  }

	void render() {
		pushStyle();
		noStroke();
		fill(0);
		ellipse(pos.x, pos.y, 10, 10);
		popStyle();
	}
}

Player player;
final float VEL = 2;

void setup() {
	size(500,500);
	player = new Player();
}

void draw() {
	background(255);
	player.renderTrack();
	player.render();
}


void keyPressed() {
	player.stop();
	if (key == 'a')
		player.setVel(-VEL, 0);
	if (key == 'd')
		player.setVel(VEL, 0);
	if (key == 'w')
		player.setVel(0, -VEL);
	if (key == 's')
		player.setVel(0, VEL);
	player.update();
}


float sqdist(PVector p1, PVector p2) {
	return (p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y);
}
