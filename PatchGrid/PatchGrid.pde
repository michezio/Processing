int GRID_SIZE = 5;
float HUE_SHIFT = 0.3;
float FADE = 0.5;
float CORNER_RADIUS = 10;
float MARGIN = 3;
float PROBABILITY = 0.05;
QuadGrid QG;
float hue = 0;

void setup() {
  fullScreen();
  //size(2340, 1080);
  colorMode(HSB);
  frameRate(30);
  
  float size = round(min(width, height) * GRID_SIZE / 100.0);

  QG = new QuadGrid(size);
  
  noStroke();
}

void draw() {
  background(0);
  
  if (random(1) < PROBABILITY)
    QG.set(floor(random(QG.w)), floor(random(QG.h)), 255);
  
  QG.show(hue);
  
  hue = (hue + HUE_SHIFT) % 255;

  /*
  pushStyle();
  fill(255);
  textSize(24);
  text(frameRate, 10, 34);
  popStyle();
  */
}

void mousePressed() {
  QG.set(QG.getX(mouseX), QG.getY(mouseY), 255);
}

void mouseDragged() {
  mousePressed();
}
