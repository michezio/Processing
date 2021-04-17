int ITERATIONS = 2000;
int CLEANOUT = 0;
int THRESH = 4;
int PPF = 100000;
float CURVE = 0.4;

float XMIN = -1.5;
float XMAX = 0.75;
float YMIN = -1.125;
float YMAX = 1.125;

int ctr = 0;
long points = 0;

int[][] heatmap;
float[][] image;

void setup()
{
  size(1000,1000);
  background(0);
  
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
  for (int i=0; i<PPF; ++i)
    populateHeatmap();

  float max = 1;
  for (int i=0; i<height; ++i)
  {
    float m = max(heatmap[i]);
    if (m > max) max = m;
  }
  
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
      set(j,i,color(map(pow(heatmap[i][j]/max,CURVE),0,1,0,255)));
  println(points);
}

void populateHeatmap()
{
  int n = 0;
  float ca = random(XMIN,XMAX);
  float cb = random(YMIN,YMAX);
  float a = 0;
  float b = 0;
  
  // CHECK IF IN 1° POLE (CARDIOID) OR IN 2° POLE (CIRCLE)
  float cbb = cb*cb;
  float caa = ca-0.25;
  float q = caa*caa+cbb;
  q *= q + caa;
  if (q < 0.25*cbb || (ca+1)*(ca+1)+cbb < 0.0625) n = ITERATIONS;
  else 
    while (n < ITERATIONS)
    {
      float aa = a*a - b*b;
      float bb = 2*a*b;
      a = aa + ca;
      b = bb + cb;
      
      if (a*a + b*b >= THRESH) break;
      ++n;
    }

  if ( n < ITERATIONS ) return;
  
  a = 0;
  b = 0;
  for (int i=0; i<n; ++i)
  {
    float aa = a*a - b*b;
    float bb = 2*a*b;
    a = aa + ca;
    b = bb + cb;
    
    if (a > XMIN && a < XMAX && b > YMIN && b < YMAX)
    {
      int x = floor(map(a,XMIN,XMAX,0,width-0.001));
      int y = floor(map(b,YMIN,YMAX,0,height-0.001));
      ++heatmap[x][y];
      ++points;
    }
  } 
}

void keyPressed()
{
  if (key == ' ')
    saveFrame();
}