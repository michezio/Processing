final float MAX_WIDTH = 640;
final float MAX_HEIGHT = 480;

String source = "H:/Users/Shin/Pictures/bob.jpg";

Kernel red = new Kernel(new float[] {
  0, 0, 1,
  0, 5, 1,
  0, 0, 1
}, 0);
Kernel green = new Kernel(new float[] {
  1, 0, 0,
  1, 5, 0,
  1, 0, 0
}, 0);
Kernel blue = new Kernel(new float[] {
  0, 2, 0,
  0, 1, 0,
  0, 1, 0
}, 0);
Kernel mono = new Kernel(new float[] {
  0.5, -1, 0.5,
  -1, 10, -1,
  0.5, -1, 0.5
}, 0.15, new PVector(1.5, 1.5), new PVector(0, 0));

Kernel strange = new Kernel(StdK.sharpen);

PImage img;
ToonShader toon;
KernelShader ker;

void setup() {
  size(100,100,P2D);
	img = loadImage(source);
  clipImage(img, MAX_WIDTH, MAX_HEIGHT);
	surface.setSize(img.width, img.height);
  
  toon = new ToonShader(256);
  
  ker = new KernelShader(strange);
}

void draw() {
  if (frameCount < 2) surface.setLocation(4,5);
  
  image(img, 0, 0);
  
  toon.render();
  ker.render();
  
  //if (frameCount % 120 == 0) println(frameRate);
  
  noLoop();
}

void clipImage(PImage img, float w, float h) {
  if (img.width > w || img.height > h) {
    float scaleX = w/img.width;
    float scaleY = h/img.height;
    float scale = min(scaleX, scaleY);
    img.resize(round(img.width*scale), round(img.height*scale));
  }
}
