final int COUNT = 100;
final float CHROME = 10;
final float RAD = 10;
final float SPEED = 1;
final float ACCELERATION = 1.2;

Ball[] rad;

boolean record = false;

void setup()
{
  rad = new Ball[COUNT];
  for (int i=0; i<COUNT; ++i)
    rad[i] = new Ball();

  size(500,500);
  
  chromaticAberrationSetup(CHROME);
}

void draw()
{
  background(0);
  noStroke();
  fill(255);
  for (int i=0; i<COUNT; ++i)
  {
    if (rad[i].checkBoundaries())
      rad[i].move();
    else
      rad[i] = new Ball();
  }
  for (Ball B : rad)
    ellipse(B.pos.x, B.pos.y, B.rad, B.rad);
    
  chromaticAberration();
  
  if (record) saveFrame();
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
    r = random(RAD*0.1, RAD);
    rad = r;
  }

  void move()
  {
    pos.add(vel);
    vel.mult(ACCELERATION);
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
  if (key == ' ')
  {
    record = !record;
    if (record) println("START RECORDING...");
    else println("STOP RECORDING.");
  }
}