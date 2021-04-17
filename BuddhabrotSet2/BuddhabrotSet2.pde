int ITERATIONS = 20000;
int CLEANOUT = 10000;
int THRESH = 4;

float XMIN = -1.75;
float XMAX = 1;
float YMIN = -1.25;
float YMAX = 1.25;
int LIMIT = 1000;

boolean cardioid;
int ctr = 0;

int[][] heatmap;
float[][] image;

void setup()
{
  frameRate(1000);
  size(1000,1000);
  background(0);
  stroke(255,1);
  
  heatmap = new int[height][width];
  image = new float[height][width];
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
    {
      heatmap[i][j] = 0;
      image[i][j] = 0.0;
    } 
}

void draw()
{  
  println(frameRate);
  for (int i=0; i<100; ++i)
    populateHeatmap();
  
  if (ctr%120 == 0)
  {
    float max = 0;
    for (int i=0; i<height; ++i)
      for (int j=0; j<width; ++j)
        if (heatmap[i][j] > max) max = heatmap[i][j];
    max = 255.0 / max;
    
    for (int i=0; i<height; ++i)
      for (int j=0; j<width; ++j)
        set(j,i,color(heatmap[i][j]*max));
  }
  
  ++ctr;
}

void populateHeatmap()
{
  int n = 0;
  float ca = random(XMIN,XMAX);
  float cb = random(YMIN,YMAX);
  float a = ca;
  float b = cb;
  
  // CHECK IF IN 1° POLE (CARDIOID) OR IN 2° POLE (CIRCLE)
  float cbb = cb*cb;
  float caa = ca-0.25;
  float q = caa*caa+cbb;
  q *= q + caa;
  if (q < 0.25*cbb || (ca+1)*(ca+1)+cbb < 0.0625) n = ITERATIONS;

  while (n < ITERATIONS)
  {
    float aa = a*a - b*b;
    float bb = 2*a*b;
    a = aa + ca;
    b = bb + cb;
    
    if (a*a + b*b >= THRESH) break;
    
    if (a > XMIN && a < XMAX && b > YMIN && b < YMAX && n > CLEANOUT)
    {
      float x = map(a,XMIN,XMAX,0,width);
      float y = map(b,YMIN,YMAX,0,height);
      if (heatmap[floor(x)][floor(y)] < LIMIT)
        ++heatmap[floor(x)][floor(y)];
    }
    
    ++n;
  } 
}

void keyPressed()
{
  if (key == ' ')
    saveFrame();
}