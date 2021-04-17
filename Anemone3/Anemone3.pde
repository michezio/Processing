final int COUNT = 2000;
final float FORCE = 10;
final float DAMP = 1;
final float VISC = 0.1;
final float SPRING = 200;
final float SIZE = 6;
final float PERT = 6;
final float MOUSE = 10000;
final float SENSE = 5000;
final float MOVERADIUS = 300;
final float ROTATION = 0.1;

final boolean RECORD = false;

Ball[] b;
Ball center;
Ball mouse1, mouse2, mouse3;


void setup()
{
  colorMode(HSB);
  //fullScreen();
  background(0);
  size(800,800);
  b = new Ball[COUNT];
  for (int i=0; i<COUNT; i++)
    b[i] = new Ball();
  center = new Ball();
  center.p = new PVector(width/2,height/2);
  mouse1 = new Ball();
  mouse1.p = new PVector(MOVERADIUS,0);
  mouse1.p.add(center.p);
  mouse2 = new Ball();
  mouse2.p = new PVector(MOVERADIUS,0);
  mouse2.p.rotate(TWO_PI/3);
  mouse2.p.add(center.p);
  mouse3 = new Ball();
  mouse3.p = new PVector(MOVERADIUS,0);
  mouse3.p.rotate(2*TWO_PI/3);
  mouse3.p.add(center.p);
}

void draw()
{
  noStroke();
  fill(0,255);
  rect(0,0,width,height);
  for (Ball B : b) B.stop();
  for (int i=0; i<COUNT; ++i)
  { 
    for (int j=0; j<COUNT; ++j)
    {
      if (i == j) continue;
      b[i].repell(b[j]);
    }
    b[i].springForce(center, SPRING);
    b[i].mouseForce(mouse1, MOUSE);
    //b[i].mouseForce(mouse2, MOUSE);
    //b[i].mouseForce(mouse3, MOUSE);
    b[i].update();
    b[i].display();
  }
  mouse1.p.sub(center.p);
  mouse1.p.rotate(ROTATION);
  mouse1.p.add(center.p);
  mouse2.p.sub(center.p);
  mouse2.p.rotate(ROTATION);
  mouse2.p.add(center.p);
  mouse3.p.sub(center.p);
  mouse3.p.rotate(ROTATION);
  mouse3.p.add(center.p);
  
  if (RECORD) saveFrame();
}

void mouseClicked()
{
  for (int n=0; n<COUNT/10; ++n)
  {
    int i = floor(random(COUNT));
    b[i].v.add(PVector.random2D().mult(PERT));
  }
}