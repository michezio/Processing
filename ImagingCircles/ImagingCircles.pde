final float SPEED = 1;
PImage img;
int ELEMENTS = 20000;
float SIZE = 7;
int OPACITY = 255;
float CURVE = 1;

class Point
{
  PVector vel;
  PVector pos;
  
  Point()
  {
    vel = new PVector(SPEED,0);
    vel.rotate(random(TWO_PI));
    pos = new PVector(random(width),random(height));
  }
  
  void update()
  {
    pos.add(vel);
  }
}

Point[] circ;

void setup()
{
  size(960,540,P3D);
  colorMode(HSB);
  noStroke();
  
  circ = new Point[ELEMENTS];
  for (int i=0; i<ELEMENTS; i++)
    circ[i] = new Point();
  
  img = loadImage("/home/hytron/Immagini/Images/CaraBW2.jpg");
  img.resize(width,height);
  img.loadPixels();
}

void draw()
{
  background(255);
  for (int i=0; i<ELEMENTS; i++)
  {
    circ[i].update();
    if ( circ[i].pos.x < 0 || circ[i].pos.x > width || circ[i].pos.y < 0 || circ[i].pos.y > height )
      circ[i] = new Point();
    color C = img.pixels[floor(circ[i].pos.y)*width+floor(circ[i].pos.x)];
    float a = map(pow(brightness(C),CURVE),0,255,200,0);
    fill(0,0,0,a);
    ellipse(circ[i].pos.x,circ[i].pos.y,SIZE,SIZE);
  }
  //saveFrame();
}