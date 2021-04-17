final int   DIM = 3;
final float TRACTION = 0.1;
      float MAXSPEED = 7;
final int   VARIANCE = 120;
final int   COUNT = 3000;
final int   OPACITY = 255;

boolean RECORD = false;

PImage img;
Ball[] b;
float decr = 1;
void setup()
{
  colorMode(RGB);
  size(100,100,P2D);
  surface.setResizable(true);
  img = loadImage("H:/Users/Shin/Pictures/Fiam5.jpg");
  img.resize(round(img.width/2),round(img.height/2));
  surface.setSize(img.width, img.height);
  
  b = new Ball[COUNT];
  for (int i=0; i<COUNT; ++i) b[i] = new Ball();
  
  strokeCap(ROUND);
  
  background(0);
}

void draw()
{
  //image(img,0,0);
  for (Ball B : b) 
  {
    if (B.pos.x > width || B.pos.x < 0 || B.pos.y > height || B.pos.y < 0)
      B.update(color(0));
    else B.update(img.get(round(B.pos.x),round(B.pos.y)));
    B.showLine();
    //B.anchorShow();
  }
  
  decr -= 0.00001;
  MAXSPEED *= decr;
  
  if (RECORD && MAXSPEED > 0.01) saveFrame();
  else if (RECORD) {
    RECORD = false;
    println("COMPLETED");
  }
}

class Ball
{
  PVector prev;
  PVector pos;
  float dim;
  PVector vel;
  PVector acc;
  PVector anchor;
  int timer;
  color prevC;
  color newC;
  
  Ball()
  {
    pos = new PVector(random(width),random(-height/3));
    prev = pos.copy();
    anchor = new PVector(random(width),random(height/3,height));
    PVector phi = anchor.copy();
    phi.sub(pos);
    acc = PVector.fromAngle(phi.heading());
    acc.mult(TRACTION);
    vel = acc.copy();
    dim = random(DIM/10,DIM);
    timer = 0;
  }
  
  void show()
  {
    noStroke();
    fill(newC,OPACITY);
    ellipse(pos.x, pos.y, dim, dim);
  }
  
  void showLine()
  {
    float R = (red(prevC)+red(newC))/1.8;
    float G = (green(prevC)+green(newC))/2.0;
    float B = (blue(prevC)+blue(newC))/2.0;
    stroke(color(R,G,B,OPACITY));
    strokeWeight(dim);
    line(prev.x,prev.y,pos.x,pos.y);
  }
  
  void anchorShow()
  {
    noFill();
    stroke(255);
    ellipse(anchor.x, anchor.y, dim, dim);
  }
  
  void update(color c)
  {
    if (++timer % VARIANCE == 0) anchor = new PVector(random(width/10,9*width/10),random(height)-height/4);
    
    PVector phi = anchor.copy();
    phi.sub(pos);
    acc = PVector.fromAngle(phi.heading());
    acc.mult(TRACTION);
    vel.add(acc);
    vel.limit(MAXSPEED);
   
    prev = pos.copy();
    pos.add(vel);
    
    prevC = newC;
    newC = c;
  }
}
