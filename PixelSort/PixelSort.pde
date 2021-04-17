PImage img;
PImage sorted;

float rateo = 2;

void setup()
{
  frameRate(1000);
  img = loadImage("3.jpg");
  img.resize(round(img.width/rateo),round(img.height/rateo));
  sorted = createImage(img.width, img.height, RGB);
  size(100, 100);
  surface.setResizable(true);
  surface.setSize(img.width*2,img.height);
  
  sorted = img.get();
  
  img.loadPixels();
  sorted.loadPixels();
}

void draw()
{
  sorted.loadPixels();
  
  

  for (int x = 0; x < sorted.width; ++x)
  {
    boolean swap = true;
    if (swap)
    {
      swap = false;
      for (int y=0; y < sorted.height-1; ++y)
      {
        if (
              brightness(sorted.pixels[x + y*sorted.width]) < brightness(sorted.pixels[x + (y+1)*sorted.width])
              //|| red(sorted.pixels[x + y*sorted.width]) > red(sorted.pixels[x + (y+1)*sorted.width])
           )
        {
          color temp = sorted.pixels[x + y*sorted.width];
          sorted.pixels[x + y*sorted.width]=sorted.pixels[x + (y+1)*sorted.width];
          sorted.pixels[x + (y+1)*sorted.width]=temp;
          swap = true;
        }  
      }
    }
  }
  
  sorted.updatePixels();
  image(img,0,0);
  image(sorted, img.width, 0);
}