final int COUNT = 1000;
final float FORCE = 20;
final float DAMP = 0.99;
final float VISC = 0.05;
final float SPRING = 400;
final float SIZE = 6;
final float PERT = 6;
final float MOUSE = 300;
final float SENSE = 200;

Ball[] b;
Ball center;
Ball mouse;

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
  mouse = new Ball();
  mouse.p = new PVector(mouseX,mouseY);
}

void draw()
{
  noStroke();
  fill(0,50);
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
    b[i].mouseForce(mouse, MOUSE);
    b[i].update();
    b[i].display();
  }
  mouse.p.set(mouseX,mouseY);
}

void mouseClicked()
{
  for (int n=0; n<COUNT/10; ++n)
  {
    int i = floor(random(COUNT));
    b[i].v.add(PVector.random2D().mult(PERT));
  }
}