float t = 0;
PVector place;
Line3D liss;

float FREQ = 0.02;
float SCALE = 200;
float DEPTH = -800;
float HUESHIFT = 1;
int DIMENSION = round(TWO_PI/FREQ)*10;
color COLOR = color(50,255,50);

float Wx = 1;
float Wy = 2;
float Wz = 6;
float Ax = 2;
float Ay = 2;
float Az = 2;

void setup()
{
  colorMode(HSB);
  size(800,800,P3D);
  hint(ENABLE_STROKE_PERSPECTIVE);
  background(0);
  liss = new Line3D(DIMENSION);
  place = new PVector(0,0,0);
}

void draw()
{
  println(frameRate);
  clear();
  camera(2*mouseX,2*mouseY,-DEPTH,width/2,height/2,DEPTH/2,0,1,0);
  translate(width/2,height/2,DEPTH/2);
  place.set(x(t),y(t),z(t));
  liss.update(place);
  liss.show();
  t += FREQ;
}

float x(float tt)
{
  float x = Ax*cos(tt*Wx);
  return SCALE*x;
}

float y(float tt)
{
  float y = Ay*sin(tt*Wy);
  return SCALE*y;
}

float z(float tt)
{
  float z = Az*sin(tt*Wz);
  return SCALE*z;
}