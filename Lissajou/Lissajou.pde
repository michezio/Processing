float t = 0;
float FREQ = 0.01;
float SCALE = 100;
float Wx = 9;
float Wy = 8;
float Ax = 1;
float Ay = 1;

void setup()
{
  frameRate(1000);
  size(800,800);
  background(0);
  strokeCap(SQUARE);
}

void draw()
{
  translate(width/2,height/2);
  stroke(50,255,50,50);
  strokeWeight(4);
  line(x(t-1),y(t-1),x(t),y(t));
  t = t+1;
}

float x(float tt)
{
  float t = tt*FREQ;
  float x = Ax*cos(t*Wx);
  return SCALE*x;
}

float y(float tt)
{
  float t = tt*FREQ;
  float y = Ay*sin(t*Wy);
  return SCALE*y;
}