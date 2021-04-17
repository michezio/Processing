Pixel[][] mosaic;

int DIMENSION = 20;
int RADIATION = 50;
float SENS = 100;
float FADE = 10;
float WABBLE = 0;

float RED = 255;
float GREEN = 255;
float BLUE = 255;

float mouseXX;
float mouseYY;
int WIDTH = 0;
int HEIGHT = 0;
boolean clk = false;

void setup()
{
  size(640,480);
  background(255);
  WIDTH = floor(width/DIMENSION);
  HEIGHT = floor(height/DIMENSION);  
  mosaic = new Pixel[WIDTH][HEIGHT];
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
    {
      mosaic[i][j] = new Pixel(i,j);
    }
}

void draw()
{
  background(255);
  mouseXX = mouseX + random(-1,1)*WABBLE;
  mouseYY = mouseY + random(-1,1)*WABBLE;
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
    {
      mosaic[i][j].show();
    }
}

void mousePressed()
{
  clk = true;
}

void mouseReleased()
{
  clk = false;
}

void keyPressed()
{
  if (key == ' ')
  {
    RED = random(0,255);
    GREEN = random(0,255);
    BLUE = random(0,255);
  }
  if (key == 'r')
  {
    RED = 255;
    GREEN = 0;
    BLUE = 0;
  }
  if (key == 'g')
  {
    GREEN = 255;
    RED = 0;
    BLUE = 0;
  }
  if (key == 'b')
  {
    BLUE = 255;
    RED = 0;
    GREEN = 0;
  }
  if (key == 'w')
  {
    RED = 255;
    GREEN = 255;
    BLUE = 255;
  }
  if (key == 'k')
  {
    RED = 0;
    GREEN = 0;
    BLUE = 0;
  }
  
}