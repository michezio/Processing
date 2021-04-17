final int COUNT = 50;

MorphBubble2D[] b;

void setup() {
	size(800,600,P3D);
  colorMode(HSB);
  b = new MorphBubble2D[COUNT];
  for (int i=0; i<COUNT; ++i)
    b[i] = new MorphBubble2D();
  blendMode(EXCLUSION);
}

void draw() {
	background(0);
  for (int i=0; i<COUNT; ++i) {
    b[i].update();
    b[i].show();
  }
}

void keyPressed() {
  if (key == 's') saveFrame();
}
