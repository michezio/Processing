Pixel[][] mosaic;
int DIMENSION = 20;
int RADIATION = 100;
int SHADE = 40;
int WIDTH = 0;
int HEIGHT = 0;
float RED = 255;
float GREEN = 100;
float BLUE = 0;
float BLURRING = 20;
float PERMANENCE = 0.99;

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
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
    {
      mosaic[i][j].show();
    }
}