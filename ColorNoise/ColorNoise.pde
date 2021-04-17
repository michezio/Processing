void setup() {
  size(400,400);
  
  noLoop();
}

void draw() {
  loadPixels();
  for (int i=0; i<width*height; ++i) {
    pixels[i] = color(random(255), random(255), random(255));
  }
  updatePixels();
  saveFrame("noise.png");
}
