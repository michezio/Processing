float SPEED = 0.3;
float MAGNET = 60;
float DENSITY = 10;
float HUESHIFT = 0.1;
float COHERENCE = 9.5;
float ECHO = 252;
float OPACITY = 50;

int COUNT = 200;
int BIAS = 0;
float hue;

Circle[] circ;

void setup()
{
  //fullScreen(P3D);
  size(600,480,P3D);
  background(0);
  frameRate(400);
  circ = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle();
    circ[i].pos.set(random(width),random(height));
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
  
  BIAS = floor(random(256));
}

void draw()
{
  noStroke();
  fill(0,255-ECHO);
  rect(0,0,width,height);
  for (int i=0; i<COUNT; i++)
  {
    for (int j=i+1; j<COUNT; j++)
    {
      float d = distance(circ[i],circ[j]);
      if (d < MAGNET*MAGNET && d >= DENSITY*DENSITY)
      {
        float m = (circ[i].ctr+circ[j].ctr)/COHERENCE;
        stroke((hue+BIAS+m)%256, 255, 255, OPACITY);
        line(circ[i].pos.x, circ[i].pos.y, circ[j].pos.x, circ[j].pos.y);
      }
    }
    if (circ[i].pos.y < -2*MAGNET)
      circ[i] = new Circle();
    else circ[i].update();
  }
  hue += HUESHIFT;
  //saveFrame();
}

void mouseClicked()
{
  BIAS = floor(random(256));
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}
