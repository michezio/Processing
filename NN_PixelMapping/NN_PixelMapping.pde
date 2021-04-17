ToyNeuralNetwork nn;
boolean learning = true;
boolean infering = false;
boolean realtime = false;
final int STEPS = 10000;

final String path = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\Img\\";
final String source = "greencrystal.png";
final String modif = "brain.png";
final String newSource = "guitar.png";

PImage src;
PImage mod;
PImage nSrc;
PImage output;

void setup() {
  size(800,800);
  nn = new ToyNeuralNetwork(3,5,3);
  
  src = loadImage(path + source);
  mod = loadImage(path + modif);
  nSrc = loadImage(path + newSource);
  output = createImage(nSrc.width, nSrc.height, RGB);
  
  image(src, 0, 0);
  image(mod, src.width, 0);
  image(nSrc, 0, src.height);
}

void draw() {
  
  for (int i=0; i<STEPS && learning; ++i) {
    int w = floor(random(src.width*src.height));
    
    src.loadPixels();
    color x = src.pixels[w];
    double[] in = c2a(x);
    
    mod.loadPixels();
    color y = mod.pixels[w];
    double[] out = c2a(y);

    nn.train(in,out);
  }
  
  if (infering || realtime) {
    nSrc.loadPixels();
    output.loadPixels();
    for (int j=0; j<nSrc.height; ++j) {
      for (int i=0; i<nSrc.width; ++i) {
        color x = nSrc.pixels[i + j*nSrc.width];
        double[] out = nn.infer(c2a(x));
        output.pixels[i + j*nSrc.width] = a2c(out);
      }
    }
    output.updatePixels();
    infering = false;
    println("UPDATED");
  }
  image(output, src.width, src.height);
  //noLoop();
}

void keyPressed() {
  if (key == 'd') {
    learning = !learning;
    if (learning) {
      println("LEARNING");
      //noLoop();
    }
    else {
      infering = true;
      println("INFERENCE");
      //loop();
    }
  }
  
  if (key == 'r') {
    realtime = !realtime;
    if (realtime) println("REALTIME");
    else println("NO REALTIME");
  }
  
  if (key == 'f') {
    println(frameRate);
  }
}

double[] c2a(color c) {
  double[] a = new double[3];
  a[0] = map(red(c),0,255,0,1);
  a[1] = map(green(c),0,255,0,1);
  a[2] = map(blue(c),0,255,0,1);
  return a;
}

color a2c(double[] a) {
  color c = color(map((float)a[0],0,1,0,255), map((float)a[1],0,1,0,255), map((float)a[2],0,1,0,255));
  return c;
}
