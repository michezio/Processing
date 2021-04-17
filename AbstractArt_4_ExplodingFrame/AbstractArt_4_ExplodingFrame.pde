float SPEED = 3;
float MAGNET = 60;
float COMP = 1;
int DENSITY = 30;
float IGNORE = 10;
float HUESHIFT = 0.7;
float ECHO = 225;
float OPACITY = 50;
float COHERENCE = 40;
int LIFETIME = 1500;

int COUNT = 150;
int BIAS = 0;
float hue;

ArrayList<Circle> circ;

void setup()
{
  fullScreen(P3D);
  //size(600,480);
  background(0);
  
  circ = new ArrayList<Circle>();
  
  for (int i=0; i<COUNT; i++)
  {
    circ.add(new Circle());
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
  
  for (int i=circ.size()-1; i>=0; i--)
  {
    Circle ii = circ.get(i);
    for (int j=i-1; j>=0; j--)
    {
      Circle jj = circ.get(j);
      float d = distance(ii,jj);
      if (d < MAGNET*MAGNET && d > IGNORE*IGNORE)
      {
        float m = (ii.ctr+jj.ctr)/COHERENCE;
        stroke((hue+BIAS+m)%256, 255, 255, OPACITY);
        line(ii.pos.x, ii.pos.y, jj.pos.x, jj.pos.y);
      }
    }
    if ( ii.pos.y > height+2*MAGNET || ii.pos.y < 0-2*MAGNET 
         || ii.pos.x > width+2*MAGNET || ii.pos.x < 0-2*MAGNET 
         || ii.ctr > LIFETIME )
      circ.remove(i);
    else ii.update();
  }
  
  while (circ.size() < COUNT)
  {
    circ.add(new Circle());
  }
  
  hue += HUESHIFT;
}

void mouseClicked()
{
  for (int i=0; i<DENSITY; i++)
  {
    circ.add(new Circle(mouseX,mouseY));
  }
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame();
  }
}