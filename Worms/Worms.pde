/**
 * Worms by Michele Abruzzese
 * based on Sparks
 * by CalsignLabs
 */

ArrayList<Worm> worms;

void setup() {
  // Use OpenGL
  fullScreen(OPENGL);
  
  worms = new ArrayList<Worm>();
  for (int i=0; i<100; i++)
    worms.add(new Worm());
  
  // Switch to HSB for cool color blending
  colorMode(HSB, 360, 100, 100);
  strokeCap(ROUND);
  
  frameRate(20);
  //smooth(8);
  background(0);
}

void draw() {
  fill(0, 20);
  if (frameCount % 15 == 0)
    fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  
  for (Worm w : worms) {
    w.update();
    w.display();
  }
}
