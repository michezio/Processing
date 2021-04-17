ToyNeuralNetwork nn;
boolean learning = true;
boolean infering = false;
boolean realtime = true;
final int STEPS = 10000;
final double INCR = 1.1;

final String path = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\Img\\";
final String source = "guitar_inv.png";
final String modif = "guitar_bl.png";
final String newSource = "guitar.png";

PImage src;
PImage mod;
PImage nSrc;
PImage output;

void setup() {
  size(800,800);
  nn = new ToyNeuralNetwork(15,3);
  
  src = loadImage(path + source);
  mod = loadImage(path + modif);
  nSrc = loadImage(path + newSource);
  output = createImage(nSrc.width, nSrc.height, RGB);
  
  image(src, 0, 0);
  image(mod, src.width, 0);
  image(nSrc, 0, src.height);
}

void draw() {
  int max = src.width;
  
  for (int i=0; i<STEPS && learning; ++i) {
    
    int x = floor(random(src.width - 0.1));
    int y = floor(random(src.height - 0.1));
    
    src.loadPixels();
    color cin = src.pixels[index(x,y,max)];
    double[] in = cross2a(cin, src.pixels[index(x,y-1,max)], src.pixels[index(x,y+1,max)],
                               src.pixels[index(x+1,y,max)], src.pixels[index(x-1,y,max)]);
    
    mod.loadPixels();
    color cout = mod.pixels[index(x,y,max)];
    double[] out = c2a(cout);//, hue(mod.pixels[index(x,y-1,max)]), hue(mod.pixels[index(x,y+1,max)]),
                                 //hue(mod.pixels[index(x+1,y,max)]), hue(mod.pixels[index(x-1,y,max)]));

    nn.train(in,out);
  }
  
  if (infering || realtime) {
    nSrc.loadPixels();
    output.loadPixels();
    for (int y=0; y<nSrc.height; ++y) {
      for (int x=0; x<nSrc.width; ++x) {
        color in = nSrc.pixels[index(x,y,max)];
        double[] out = nn.infer(cross2a(in, nSrc.pixels[index(x,y-1,max)], nSrc.pixels[index(x,y+1,max)],
                                            nSrc.pixels[index(x+1,y,max)], nSrc.pixels[index(x-1,y,max)]));
        output.pixels[index(x,y,max)] = a2c(out);
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

int index(int x, int y, int max) {
  return index(x, y, max, max);
}

int index(int x, int y, int maxX, int maxY) {
  x = (x < 0) ? (maxX + x) : (x % maxX);
  y = (y < 0) ? (maxY + y) : (y % maxY);
  return (x + y * maxX);
}

double[] cross2a(color c, color hn, color hs, color hw, color he) {
  double[] a = new double[15];
  a[0] = map(red(c),0,255,0,1);
  a[1] = map(green(c),0,255,0,1);
  a[2] = map(blue(c),0,255,0,1);
  a[3] = map(red(hn),0,255,0,1);
  a[4] = map(green(hn),0,255,0,1);
  a[5] = map(blue(hn),0,255,0,1);
  a[6] = map(red(hs),0,255,0,1);
  a[7] = map(green(hs),0,255,0,1);
  a[8] = map(blue(hs),0,255,0,1);
  a[9] = map(red(hw),0,255,0,1);
  a[10] = map(green(hw),0,255,0,1);
  a[11] = map(blue(hw),0,255,0,1);
  a[12] = map(red(he),0,255,0,1);
  a[13] = map(green(he),0,255,0,1);
  a[14] = map(blue(he),0,255,0,1);
  return a;
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
