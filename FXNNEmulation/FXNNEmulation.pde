final String newSource = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\michezio.png";

ToyNeuralNetwork nn;
boolean learning = true;
boolean infering = false;
boolean realtime = true;
final int STEPS = 10000;
final double INCR = 1.1;
int SIZE = 300;

final boolean COLOR_ONLY = true;
final int COMPLEXITY = 0;
final String source = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\Img\\noise1.png";
final String modif = "H:\\Users\\Shin\\Pictures\\DesignConcepts\\Img\\noise1_heat3.png";

PImage src;
PImage mod;
PImage nSrc, inTemp, outTemp, output;

void setup() {
  size(600,600);
  surface.setSize(2*SIZE, 2*SIZE);
  
  if (COLOR_ONLY) {
    if (COMPLEXITY > 0) nn = new ToyNeuralNetwork(3,COMPLEXITY,3);
    else nn = new ToyNeuralNetwork(3,3);
  }
  else if (COMPLEXITY > 0) nn = new ToyNeuralNetwork(27,COMPLEXITY,3);
  else nn = new ToyNeuralNetwork(27,3);
  
  src = loadImage(source);
  src.resize(2*SIZE, 2*SIZE);
  mod = loadImage(modif);
  mod.resize(2*SIZE, 2*SIZE);
  nSrc = loadImage(newSource);
  inTemp = nSrc.copy();
  inTemp.resize(SIZE, SIZE);
  outTemp = createImage(SIZE, SIZE, RGB);
  output = createImage(nSrc.width, nSrc.height, RGB);
  
  image(src, 0, 0, SIZE, SIZE);
  image(mod, SIZE, 0, SIZE, SIZE);
  image(inTemp, 0, SIZE);
}

void draw() {
  int max = 2*SIZE;
  
  for (int i=0; i<STEPS && learning; ++i) {
    
    int x = floor(random(max - 0.1));
    int y = floor(random(max - 0.1));
    
    src.loadPixels();
    double[] in;
    if (COLOR_ONLY) in = c2a(src.pixels[index(x,y,max)]);
    else in = square2a(src.pixels[index(x-1,y-1,max)], src.pixels[index(x,y-1,max)], src.pixels[index(x+1,y-1,max)],
                       src.pixels[index(x-1,y,max)],   src.pixels[index(x,y,max)],   src.pixels[index(x+1,y,max)],
                       src.pixels[index(x-1,y+1,max)], src.pixels[index(x,y+1,max)], src.pixels[index(x+1,y+1,max)]);
    
    mod.loadPixels();
    color cout = mod.pixels[index(x,y,max)];
    double[] out = c2a(cout);

    nn.train(in,out);
  }
  
  if (infering || realtime) {
    max = SIZE;
    inTemp.loadPixels();
    outTemp.loadPixels();
    for (int y=0; y<max; ++y) {
      for (int x=0; x<max; ++x) {
        double[] out;
        if (COLOR_ONLY) out = nn.infer(c2a(inTemp.pixels[index(x,y,max)]));
        else out = nn.infer(square2a(inTemp.pixels[index(x-1,y-1,max)], inTemp.pixels[index(x,y-1,max)], inTemp.pixels[index(x+1,y-1,max)],
                                     inTemp.pixels[index(x-1,y,max)],   inTemp.pixels[index(x,y,max)],   inTemp.pixels[index(x+1,y,max)],
                                     inTemp.pixels[index(x-1,y+1,max)], inTemp.pixels[index(x,y+1,max)], inTemp.pixels[index(x+1,y+1,max)]));
        outTemp.pixels[index(x,y,max)] = a2c(out);
      }
    }
    outTemp.updatePixels();
    infering = false;
  }
  image(outTemp, SIZE, SIZE);
}

void keyPressed() {
  
  if (key == ' ') {
    println("GENERATING...");
    int w = nSrc.width;
    int h = nSrc.height;
    
    nSrc.loadPixels();
    output.loadPixels();
    for (int y=0; y<h; ++y) {
      for (int x=0; x<w; ++x) {
        double[] out;
        if (COLOR_ONLY) out = nn.infer(c2a(nSrc.pixels[index(x,y,w,h)]));
        else out = nn.infer(square2a(nSrc.pixels[index(x-1,y-1,w,h)], nSrc.pixels[index(x,y-1,w,h)], nSrc.pixels[index(x+1,y-1,w,h)],
                                         nSrc.pixels[index(x-1,y,w,h)],   nSrc.pixels[index(x,y,w,h)],   nSrc.pixels[index(x+1,y,w,h)],
                                         nSrc.pixels[index(x-1,y+1,w,h)], nSrc.pixels[index(x,y+1,w,h)], nSrc.pixels[index(x+1,y+1,w,h)]));
        output.pixels[index(x,y,w,h)] = a2c(out);
      }
    }
    output.updatePixels();
    output.save(newSource + "GENERATED.png");
    println("COMPLETED!");
  }
  
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

double[] square2a(color tl, color tc, color tr, color cl, color cc, color cr, color bl, color bc, color br) {
  double[] a = new double[27]; 
  color x = tl;
  for (int i=0; i<27; i+=3) {
    if (i == 3) x = tc;
    else if (i == 6) x = tr;
    else if (i == 9) x = cl;
    else if (i == 12) x = cc;
    else if (i == 15) x = cr;
    else if (i == 18) x = bl;
    else if (i == 21) x = bc;
    else if (i == 24) x = br;
    a[i] = map(red(x),0,255,0,1);
    a[i+1] = map(green(x),0,255,0,1);
    a[i+2] = map(blue(x),0,255,0,1);
  }
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
