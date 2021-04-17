int SPARSE = 20;
float RAND = 0.0;
float SIZE = 5;

PImage image;

void setup()
{
  //noLoop();
  size(720,480);
  colorMode(HSB);
  image = loadImage("Cara.jpg");
  //image.filter(BLUR);
}

void draw()
{
  if (SPARSE>0)
  {
    background(255);
    float B;
    float S = SPARSE/2.0;
    for(int i=0; i<width; i=i+SPARSE)
    for(int j=0; j<height; j=j+SPARSE)
    {
      B = 0;
      for(int x=0; x<SPARSE; x++)
      for(int y=0; y<SPARSE; y++)
      {
        B += brightness(image.get(i+x,j+y));
      }
      B /= SPARSE*SPARSE;
      float x = random(-S,S)*RAND;
      float y = random(-S,S)*RAND;
      float d = random(SPARSE*SIZE);
      noStroke();
      float t = map(255-B,0,255,0,200);
      fill(random(256),255,random(256),t);
      //fill(0,t);
      ellipse(i+S+x,j+S+y,d,d);
    }
    if (SPARSE>1) SPARSE--;
    else
    {
      SPARSE = 1;
      println("DONE");
    }
    //saveFrame();
  }
}