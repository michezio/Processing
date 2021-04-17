
int COUNT = 300;
final float DAMP = 0.8;
final float VISC = 0.02;
float FORCE = 10;
float THRESH = 80;
float SIZE = 8;
float SIGHT = 350;
float DIFFUSION = 0.001;

ArrayList<Ball> b;
QuadGrid qg;

float hue;


void setup()
{
  colorMode(HSB);

  fullScreen(OPENGL);
  orientation(PORTRAIT);
  frameRate(30);
  
  hue = random(255);
  b = new ArrayList<Ball>();
  for (int i=0; i<COUNT; i++) {
    b.add(new Ball(random(width), random(height)));
  }
  
  qg = new QuadGrid(SIGHT);
  
  background(0);
  mouseReleased();
}

void draw()
{
  noStroke();
  if (frameCount+30 % 60 == 0) fill(0,80);
  else if (frameCount % 60 == 0) fill(0, 128);
  else fill(0, 65);
  rect(0,0,width,height);
 
  qg.reset();
  for (Ball B : b) {
    B.stop();
    qg.insert(B);
  }
  
  for (Ball A : b)
  { 
    ArrayList<Ball> toCheck = qg.query(A.p.x, A.p.y, SIGHT);
    //toCheck.remove(A);
      for (Ball B : toCheck)
      {
        if (B != A)
          A.interact(B);
      }
    A.update();
    A.display();
  }
  
/* 
  pushStyle();
  textSize(30);
  fill(255);
  text(frameRate, 10, 40);
  popStyle();
*/
  
}

void mouseDragged()
{
  for (int i=0; i<1; i++) {
    b.add(new Ball(mouseX + random(-SIZE,SIZE), mouseY + random(-SIZE,SIZE)));
    if (b.size() > COUNT)
    b.remove(0);
  }
}

void mousePressed()
{
  for (int i=0; i<5; ++i) mouseDragged();
}

void mouseReleased()
{
  hue = (hue + 63 + random(64)) % 256;
}
