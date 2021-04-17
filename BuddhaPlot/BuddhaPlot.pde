/** NOT WORKING **/

int BAIL = 4;
int ITER = 5000;
int LITER = 100;
int PTS = 1000;

float cr, ci;
float zr, zi;
float[] list;
float[] points;

int k = 0;

void setup()
{
  frameRate(1000);
  size(500,500);
  background(0);
  stroke(255,10);
  
  list = new float[ITER*2];
  for (int i=0; i<ITER*2; i++)
    list[i] = 0;
  
  points = new float[PTS*3];
  for (int i=0; i<PTS; ++i)
  {
    boolean toContinue = true;
    while(toContinue)
    {
      cr = random(-2,2);
      ci = random(-2,2);
      // CHECK IF IN 1° POLE (CARDIOID) OR IN 2° POLE (CIRCLE)
      float cii = ci*ci;
      float crr = cr-0.25;
      float q = crr*crr+cii;
      q *= q + crr;
      if (q < 0.25*cii || (cr+1)*(cr+1)+cii < 0.0625) continue;
      else 
      {
        int k=0;
        zr = 0;
        zi = 0;
        for (k=0; k<ITER; ++k)
        {
          zr = zr*zr-zi*zi+cr;
          zi = 2*zr*zi+ci;
          if (zr*zr+zi*zi > BAIL) break;
        }
        if (k < ITER && k > LITER)
        {
          points[3*i] = cr;
          points[3*i+1] = ci; 
          points[3*i+2] = k;
          toContinue = false;
        }
      }
    }
  }
}

void draw()
{
  println(frameRate);
  cr = points[3*k];
  ci = points[3*k+1];
  float lim = points[3*k+2];
  k++;
  zr = 0;
  zi = 0;
  float zrr = zr*zr;
  float zii = zi*zi;
  
  int n = 0;
  while(n < lim)
  {
    zr = zr*zr-zi*zi+cr;
    zi = 2*zr*zi+ci;
    float y = map(zr, -2,2, 0,height);
    float x = map(zi, -2,2, 0,width);
    point(y,x);
    ++n;
  }
}
