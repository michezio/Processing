Pixel[][] mosaic;
ArrayList<Particle> parts;

int DIMENSION = 23;
int MAXRAD = 100;
int MINSPEED = 5;
int MAXSPEED = 20;
float SENS = 50;
float FADE = 5;
float WABBLE = 20;
int PARTS = 5;

int WIDTH = 0;
int HEIGHT = 0;

void setup()
{
  //size(640,480);
  fullScreen();
  background(255);
  parts = new ArrayList<Particle>();
  WIDTH = floor(width/DIMENSION);
  HEIGHT = floor(height/DIMENSION);  
  mosaic = new Pixel[WIDTH][HEIGHT];
  for (int i=0; i<PARTS; i++)
    parts.add(new Particle());
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
    {
      mosaic[i][j] = new Pixel(i,j);
    }
}

void draw()
{
  background(255);
  for (int i=0; i<PARTS; i++)
  {
    Particle toCheck = parts.get(i);
    toCheck.update();
    if (toCheck.isOut())
    {
      parts.remove(i);
      parts.add(new Particle());
    }
  }
  for (int i=0; i<WIDTH; i++)
    for (int j=0; j<HEIGHT; j++)
    {
      for (int k=0; k<PARTS; k++)
      {
        mosaic[i][j].update(parts.get(k));
        mosaic[i][j].show();
      }
    }
}