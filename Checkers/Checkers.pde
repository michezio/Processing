Field x;

float t;

void setup() {
	size(500,500);
	x = new Field(10,10);
	x.setDimension(width, height);
}

void draw() {
	background(0);
	x.show();
}

void keyPressed() {
  if (key == ' ') x.shuffle();
}