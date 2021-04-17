float SPEED = 5;
float MAGNET = 60;
float HUESHIFT = 0.7;
float COMP = 4;
float BKGCOMP = 2;
float ECHO = 0;
float OPACITY = 40;
float BKGOPACITY = 50;
float COHERENCE = 7.5;
float DENSITY = 10;

int COUNT = 200;
int BIAS = 0;
int BKGBIAS = 0;
float hue;

Circle[] circ, bkg;

void setup()
{
  //fullScreen(P3D);
  size(600,480,P3D);
  background(0);
  smooth(8);
  circ = new Circle[COUNT];
  bkg = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle(COMP);
    circ[i].pos.set(random(width),random(height));
  }
  
  for (int i=0; i<COUNT; i++)
  {
    bkg[i] = new Circle(BKGCOMP);
    bkg[i].pos.set(random(width),random(height));
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  
  BIAS = floor(random(256));
  BKGBIAS = BIAS;
}

void draw()
{
  noStroke();
  fill(0,255-ECHO);
  rect(0,0,width,height);
  
  strokeWeight(1);
  for (int i=0; i<COUNT; i++)
  {
    for (int j=i+1; j<COUNT; j++)
    {
      float d = distance(bkg[i],bkg[j]);
      if (d < MAGNET*MAGNET && d >= DENSITY)
      {
        float m = (bkg[i].ctr+bkg[j].ctr)/COHERENCE;
        stroke((hue+BKGBIAS+m)%256, 255, 255, BKGOPACITY);
        line(bkg[i].pos.x, bkg[i].pos.y, bkg[j].pos.x, bkg[j].pos.y);
      }
    }
    if ( bkg[i].pos.y > height+2*MAGNET || bkg[i].pos.y < 0-2*MAGNET
         || bkg[i].pos.x > width+2*MAGNET || bkg[i].pos.x < 0-2*MAGNET )
      bkg[i] = new Circle(BKGCOMP);
    else bkg[i].update();
  }
  
  PImage img = get(0,0,width,height);
  
  tint(255,255,255,255/5);
  image(img,-2,-2);
  image(img,+2,+2);
  image(img,+2,-2);
  image(img,-2,+2);
  tint(255,255,255,255);

  strokeWeight(2);
  for (int i=0; i<COUNT; i++)
  {
    for (int j=i+1; j<COUNT; j++)
    {
      float d = distance(circ[i],circ[j]);
      if (d < MAGNET*MAGNET && d >= DENSITY)
      {
        float m = (circ[i].ctr+circ[j].ctr)/COHERENCE;
        stroke((hue+BIAS+m)%256, 255, 255, OPACITY);
        line(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y);
      }
    }
    if ( circ[i].pos.y > height+2*MAGNET || circ[i].pos.y < 0-2*MAGNET
         || circ[i].pos.x > width+2*MAGNET || circ[i].pos.x < 0-2*MAGNET )
      circ[i] = new Circle(COMP);
    else circ[i].update();
  }
   
  hue += HUESHIFT;
  //saveFrame();
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}