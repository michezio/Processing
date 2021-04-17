final float ZOOM = 0.01;
final float VARI = 100;

void setup() {
  size(400,400);
  
  noLoop();
}

void draw() {
  for (int i=0; i<width; ++i) {
    for (int j=0; j<height; ++j) {
      color c = color(noise(i*ZOOM, j*ZOOM)*255, noise(i*ZOOM+VARI, j*ZOOM+VARI)*255, noise(i*ZOOM+2*VARI, j*ZOOM+2*VARI)*255);
      set(i, j, c);
    }
  }
  saveFrame("noise.png");
}
