final int COUNT = 100;
final float CHROME = 10;
final float R = 10;
final float SPEED = 0.1;

Ball[] rad;
PGraphics img;
PImage red, green, blue;
boolean record = false;

void setup()
{
  rad = new Ball[COUNT];
  for (int i=0; i<COUNT; ++i)
  {
    rad[i] = new Ball();
    rad[i].pos = new PVector(random(width),random(height));
  }

  size(800,800);
  red = createImage(width,height,RGB);
  green = createImage(width,height,RGB);
  blue = createImage(width,height,RGB);
  img = createGraphics(width,height);
}

void draw()
{
  img.beginDraw();
    img.background(0);
    img.noStroke();
    img.fill(255);
    for (int i=0; i<COUNT; ++i)
    {
      if (rad[i].checkBoundaries())
        rad[i].move();
      else
        rad[i] = new Ball();
    }
    for (Ball B : rad)
      img.ellipse(B.pos.x, B.pos.y, B.rad, B.rad);
  img.endDraw();
  aberration();
  if (record) saveFrame();
}

void aberration()
{
  PImage full = img.get();

  for (int x=0; x<full.width; ++x)
  {
    for (int y=0; y<full.height; ++y)
    {
      red.set(x,y,color(red(full.get(x,y)),0,0));
      green.set(x,y,color(0,green(full.get(x,y)),0));
      blue.set(x,y,color(0,0,blue(full.get(x,y))));
    }
  }
  
  blendMode(SCREEN);
  background(0);
  image(blue,0,0);
  image(green,-1*CHROME,-1*CHROME,width+2*CHROME,height+2*CHROME);
  image(red,-2*CHROME,-2*CHROME,width+4*CHROME,height+4*CHROME);
}

class Ball
{
  PVector pos;
  PVector vel;
  float rad;
  float r;

  Ball()
  {
    pos = new PVector(width/2,height/2);
    vel = new PVector(0,SPEED);
    vel.rotate(random(TWO_PI));
    r = random(R*0.1, R);
    rad = r;
  }

  void move()
  {
    pos.add(vel);
    vel.mult(1.05);
    rad = r*map(dist(pos.x,pos.y,width/2,height/2),0,width/1.5,1,10);
  }

  boolean checkBoundaries()
  {
    boolean alive = true;
    if (pos.x > 0 && pos.x < width && pos.y > 0 && pos.y < height)
      alive = true;
    else
      alive = false;
    return alive;
  }
}

void keyPressed()
{
  if (key == ' ') record = !record;
}