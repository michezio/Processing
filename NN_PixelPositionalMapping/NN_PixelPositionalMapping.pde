ToyNeuralNetwork nn;
boolean learning = true;
boolean infering = false;
boolean realtime = true;
final int STEPS = 10000;
final double INCR = 1.1;

final String path = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\Img\\";
final String source = "person_bw.png";
final String modif = "brain.png";
final String newSource = "guitar.png";

PImage src;
PImage mod;
PImage nSrc;
PImage output;

void setup() {
  size(800,800);
  nn = new ToyNeuralNetwork(5,10,3);
  
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
    int xpos = w % src.width;
    int ypos = floor(w/src.width);
    
    src.loadPixels();
    color cin = src.pixels[w];
    double[] in = cp2a(cin, xpos, ypos);
    
    mod.loadPixels();
    color cout = mod.pixels[w];
    double[] out = c2a(cout);

    nn.train(in,out);
  }
  
  if (infering || realtime) {
    nSrc.loadPixels();
    output.loadPixels();
    for (int j=0; j<nSrc.height; ++j) {
      for (int i=0; i<nSrc.width; ++i) {
        color x = nSrc.pixels[i + j*nSrc.width];
        double[] out = nn.infer(cp2a(x, i, j));
        output.pixels[i + j*nSrc.width] = a2c(out);
      }
    }
    output.updatePixels();
    infering = false;
    //println("UPDATED");
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
  
  if (key == '+') {
    nn.setLearningRate(nn.getLearningRate() * INCR);
    println(nn.getLearningRate());
  }
  
  if (key == '-') {
    nn.setLearningRate(nn.getLearningRate() / INCR);
    println(nn.getLearningRate());
  }
}

double[] cp2a(color c, int x, int y) {
  double[] a = new double[5];
  a[0] = map(red(c),0,255,0,1);
  a[1] = map(green(c),0,255,0,1);
  a[2] = map(blue(c),0,255,0,1);
  a[3] = map(x,0,width/2,0,1);
  a[4] = map(y,0,height/2,0,1);
  return a;
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
