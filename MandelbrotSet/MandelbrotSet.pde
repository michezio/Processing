int ITERATIONS = 200;
int INCR = 10;
int THRESH = 4;
float ZOOM = 0.75;
int COLORS = 7;

float scale = 1.5;
float xshift = -0.75;
float yshift = 0;

boolean update = true;
boolean crossair = false;
boolean smooth = false;
int scheme = 0;

boolean cardioid;
boolean black;

void setup()
{
  colorMode(HSB);
  size(501,501,JAVA2D);
  background(255);
  smooth(16);
}

void draw()
{     
  if (update)
  {
    for (int x=0; x<width; x++)
    {
      for (int y=0; y<height; y++)
      {
        colorMode(HSB);
        int n = 0;
        float ca = map(x,0,width,-scale,scale)+xshift;
        float cb = map(y,0,height,-scale,scale)+yshift;
        float a = ca;
        float b = cb;
        
        // CHECK IF IN 1° POLE (CARDIOID) OR IN 2° POLE (CIRCLE)
        float cbb = cb*cb;
        float caa = ca-0.25;
        float q = caa*caa+cbb;
        q *= q + caa;
        if (q < 0.25*cbb || (ca+1)*(ca+1)+cbb < 0.0625)
        {
          n = ITERATIONS;
          cardioid = true;
        }
        else cardioid = false;
        
        
        while (n < ITERATIONS)
        {
          float at = a;
          float bt = b;
          float aa = a*a - b*b;
          float bb = 2*a*b;
          a = aa + ca;
          b = bb + cb;
          
          if (at == a && bt == b)        // CHECK IF NOT CHANGED (PERIODIC)
          {
            n = ITERATIONS;
            break;
          }
          
          if (a*a + b*b >= THRESH) break;
          
          n++;
        }
        
        if (n == ITERATIONS) black = true;
        else black = false;
        
        float H;
        switch (scheme)
        {
          case 0:
            H = map(n, 0, ITERATIONS, 255, 0);
            set(x, y, color(0, 0, n==ITERATIONS ? 0 : H) );
            break;
          case 1:
            H = map(n, 0, ITERATIONS, 0, 255);
            set(x, y, color(H, 255, n==ITERATIONS ? 0 : 255) );
            break;
          case 2:
            H = map(n, 0, ITERATIONS, 0, 1);
            H = map(sqrt(H), 0, 1, 0, 255);
            set(x, y, color(H, 255, n==ITERATIONS ? 0 : 255) );
            break;
          case 3:
            H = map(n, 0, ITERATIONS, 0, 255);
            set(x, y, color(0, 0, n==ITERATIONS ? 0 : H) );
            break;
          case 4:
            H = map(n, 0, ITERATIONS, 255, 0);
            set(x, y, color(0, 0, n==ITERATIONS ? 255 : H) );
            break;
          case 5:
            H = map(n, 0, ITERATIONS, 0, 1);
            H = map(H*H, 0, 1, 0, 255);
            set(x, y, color(H, 255, n==ITERATIONS ? 0 : 255) );
            break;
          case 6:
            float k = 8;
            H = map(n, 0, ITERATIONS, 0, 1);
            H = map(atan(k*H)/atan(k), 0, 1, 100, 170);
            set(x, y, color(H, 255, 255) );
            break;
        }
      }
    }
    
    if (smooth) 
    {
      colorMode(RGB);
      SimpleFilter(4);
      colorMode(HSB);
    }
  }
  
  if (crossair)
  {
    int X = width/2;
    int Y = height/2;
    set(X,Y,color(255));
    set(X-1,Y,color(255));
    set(X+1,Y,color(255));
    set(X,Y-1,color(255));
    set(X,Y+1,color(255));
  }
  
  update = false;
}