int SIDE = 20;
int SPACE = 0;
float NS = 0.03;
float VAR = 0.1;
float z = 0;

void setup()
{
  size(500,500);
  background(0);
}

void draw()
{
  background(0);
  z += VAR;
  for (int x=0; x<width+SIDE; x+=SIDE)
  {
    for (int y=0; y<height+SIDE; y+=SIDE)
    {
      color c = color(gamma((noise(x*NS,y*NS,z*NS)*255),0.3));
      fill(c);
      noStroke();
      if (x%(2*SIDE)==0) rect(x+SPACE,y+SPACE,SIDE-SPACE,SIDE-SPACE);
      else rect(x+SPACE,y-SIDE/2.0+SPACE,SIDE-SPACE,SIDE-SPACE);
    }
  }
  //saveFrame();
}

float gamma(float val, float exp)
{
  return map(pow(val/255.0,exp),0,1,0,255);
}