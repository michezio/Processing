import ch.bildspur.postfx.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;

final int GRID = 25;
final float NOISE_SPEED = 0.03;
final float NS = 0.12;
final float SPACING = 1;
final float COLORSHIFT = 20;
final float PULSE_WIDTH = 40;
final float PULSE_SPEED = 0.2;

boolean record = false;

float angle = PI/3.0;
float vspace = GRID;
float hspace = vspace*cos(PI/6.0);
float side = hspace*2/3.0;
float shift = vspace/2.0;

float x,y;

Hexagon[][] grid;
int X = 0;
int Y = 0;

float phase;
PostFX aberration;

void setup()
{
  size(600,600,P2D);
  
  X = ceil(width/hspace+1); 
  Y = ceil(height/vspace+1);
  
  grid = new Hexagon[X][Y];
  
  for (int i=0; i<X; ++i)
  {
    for (int j=0; j<Y; ++j)
    {
      if (i%2 == 0) grid[i][j] = new Hexagon(i*hspace,j*vspace,side);
      else grid[i][j] = new Hexagon(i*hspace,j*vspace+shift,side);
    }
  }
  
  phase = 0;
  aberration = new PostFX(this);
}

void draw()
{
  background(0);
  
  x += NOISE_SPEED;
  
  for (int i=0; i<X; ++i)
  {
    for (int j=0; j<Y; ++j)
    {
      if (i%2 == 0) grid[i][j].show(color((noise(i*NS,j*NS,x*NS)*768)%256));
      else grid[i][j].show(color((noise(i*NS,(j+0.5)*NS,x*NS)*768)%256));
    }
  }
  
  aberration.render()
            .bloom(0.7,20,40)
            .rgbSplit(COLORSHIFT + PULSE_WIDTH*noise(phase))
            .compose();
  
  phase += PULSE_SPEED;

  if (record) saveFrame("f###.gif");
}

class Hexagon
{
  PVector pos;
  PVector[] vert;
  
  Hexagon(float x, float y, float l)
  {
    vert = new PVector[6];
    pos = new PVector(x,y);
    
    for (int i=0; i<6; ++i)
    {
      vert[i] = new PVector(l-SPACING,0);
      vert[i].rotate(i*angle);
      vert[i].add(pos);
    }
  }
  
  void show(color c) 
  {
    strokeWeight(2);
    //stroke(0);
    noStroke();
    fill(c);
    beginShape();
      for (int i=0; i<6; ++i)
        vertex(vert[i].x, vert[i].y);
    endShape(CLOSE);
  }
}
