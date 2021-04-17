int DIM = 7;
int D = DIM/2;
float MIN = 1.2;
float MAX = 3;
float RAND = 0;
float CURVE = 1;
int XOFF = 0;
int YOFF = 0;

PImage img;

void setup()
{
  noLoop();
  colorMode(HSB);
  size(960,540,P2D);
  img = loadImage("/home/hytron/Immagini/Images/CaraBW2.jpg");
  img.resize(width,height);
}

void draw()
{
  noStroke();
  background(200);
  for (int x=XOFF; x<width; x+=DIM)
  for (int y=YOFF; y<height; y+=DIM)
  {
    float B = 0;
    float H = 0;
    float S = 0;
    float c = 0;
    for (int i=0; i<DIM; i++)
    for (int j=0; j<DIM; j++)
    {
      if(x+i > img.width) continue;
      if(y+j > img.height) continue;
      B += brightness(img.get(x+i,y+j));
      H += hue(img.get(x+i,y+j));
      S += saturation(img.get(x+i,y+j));
      c++;
    }
    B /= c;
    H /= c;
    S /= c;
    float xx = x + D + random(-D,D)*RAND;
    float yy = y + D + random(-D,D)*RAND;
    
    /* COLORATION PROCEDURE */
    
      float dd = random(MIN*2*D,MAX*2*D);
      float hh = map(pow(B/255,CURVE),0,1,255,0);
      //float dd = map(pow(B/255,CURVE),0,1,2*DIM,0);
      //fill(H,S,B,127);
      fill(H,S,B,hh);
    
    ellipse(xx,yy,dd,dd);
  }
  println("DONE");
}