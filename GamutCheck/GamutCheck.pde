PImage img;

void setup()
{
	noLoop();
  //fullScreen();
	size(800,600);
	colorMode(HSB);

  img = createImage(256,512,HSB);

	for (int x=0; x<256; ++x)
	{
		int b = 255;
    int s = 0;
		for (int y=0; y<512; ++y)
		{
		  img.set(x,y,color(x,s,b));
      if (s < 256) ++s;
      else --b;
		}
	}	
}

void draw()
{
  image(img,0,0,width,height);
  saveFrame("screen.png");
}