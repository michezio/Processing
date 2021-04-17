PImage img;

void setup() {
  surface.setResizable(true);
  img = loadImage("C:/Users/Shin/Pictures/Wallpapers/zebrafish-fin.jpg");
  if (img.width > 1280 || img.height > 768) {
    img.resize(1280, 768);
  }    
  
  surface.setSize(img.width, img.height);
}  

void draw() {
  loadPixels();
  img.loadPixels();
  for (int i=0; i<pixels.length; i++) {
    color c = img.pixels[i];
    float average = (red(c) + green(c) + blue(c)) / 3.0;
    pixels[i] = color(average);
  }
  updatePixels();
}
