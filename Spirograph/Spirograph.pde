float t = 0;
float FREQ = 0.05;
float SCALE = 20;
float R = 5;
float r = 3;
float d = 3;

void setup()
{
  frameRate(1000);
  size(800,800,P2D);
  background(0);
  strokeCap(SQUARE);
}

void draw()
{
  float tbk = t;
  t = (t+FREQ);
  translate(width/2,height/2);
  strokeWeight(4);
  stroke(50,255,50,50);
  line(xi(tbk),yi(tbk),xi(t),yi(t));
  stroke(255,50,50,50);
  line(xe(tbk),ye(tbk),xe(t),ye(t));
  
}

float xi(float tt)
{
  float x = (R-r)*cos(tt)+d*cos(tt*(R-r)/r);
  return SCALE*x;
}

float yi(float tt)
{
  float y = (R-r)*sin(tt)-d*sin(tt*(R-r)/r);
  return SCALE*y;
}

float xe(float tt)
{
  float x = (R+r)*cos(tt)-d*cos(tt*(R+r)/r);
  return SCALE*x;
}

float ye(float tt)
{
  float y = (R+r)*sin(tt)-d*sin(tt*(R+r)/r);
  return SCALE*y;
}