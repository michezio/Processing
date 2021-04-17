float SPEED = 2;
float SPEEDLIMIT = 7;
float MAGNET = 60;
float HUESHIFT = 0.7;
float COMP = 3;
float OPACITY = 80;
float COHERENCE = 4.5;
float DENSITY = 10;
int LIFETIME = 1000;

int COUNT = 400;
int BIAS = 0;
float hue;

Circle[] circ;

void setup()
{
  frameRate(30);
  //fullScreen();
  size(500,500,P3D);
  hint(ENABLE_STROKE_PERSPECTIVE);
  background(0);
  
  circ = new Circle[COUNT];
  
  for (int i=0; i<COUNT; i++)
  {
    circ[i] = new Circle();
    circ[i].pos.normalize().mult(random(height));
  }
  
  colorMode(HSB);
  strokeCap(SQUARE);
  strokeWeight(2);
  
  BIAS = floor(random(256));
  
}

void draw()
{
  clear();
  translate(width/2,height/2);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  noStroke();
  for (int i=0; i<COUNT; i++)
  {
    Circle ii = circ[i];
    for (int j=i+1; j<COUNT; j++)
    {
      Circle jj = circ[j];
      float d = distance(ii,jj);
      if (d < MAGNET*MAGNET && d >= DENSITY)
      {
        float m = (ii.ctr+jj.ctr)/COHERENCE;
        stroke((hue+BIAS+m)%256, 255, 255, OPACITY);
        line(ii.pos.x, ii.pos.y, ii.pos.z, jj.pos.x, jj.pos.y, jj.pos.z);
      }
    }
    if ( dist(ii.pos.x,ii.pos.y,ii.pos.z,0,0,0) > height+2*MAGNET || ii.ctr > LIFETIME )
      circ[i] = new Circle();
    else ii.update();
  }
  hue += HUESHIFT;
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