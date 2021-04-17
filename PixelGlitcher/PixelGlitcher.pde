final String FILENAME = "/home/furgoncino/Immagini/1.jpeg";
int WIDTH; 
int HEIGHT;
float DIST = 0.1;
float AMOUNT = 2;
float ind;
float incr = 0.1;

PImage img;
PImage result;

void setup() {
	size(100,100);
	img = loadImage(FILENAME);
	img.resize(img.width/2, img.height/2);
	result = img.get();
	WIDTH = result.width;
	HEIGHT = result.height;
	surface.setSize(WIDTH, HEIGHT);
  ind = 0;
  img.loadPixels();
}

void draw() {
  result.loadPixels();
  for (int y=0; y<HEIGHT; ++y) {
    for (int x=0; x<WIDTH; ++x) {
      result.pixels[index(x,y)] = result.pixels[index(x+round((noise(x*DIST, y*DIST, ind)-0.5) * AMOUNT),
                                                   y+round((noise(x*DIST+20, y*DIST+20, ind)-0.5) * AMOUNT))];
    }
  }
  result.updatePixels();
  image(result, 0, 0);
	ind += incr;
}

int index(int x, int y, int maxX, int maxY) {
	x = (x < 0) ? (maxX + x) : (x % maxX);
	y = (y < 0) ? (maxY + y) : (y % maxY);
	return (x + y * maxX);
}

int index(int x, int y) {
	return indexNC(x, y, WIDTH, HEIGHT);
}

int indexNC(int x, int y, int maxX, int maxY) {
  x = (x < 0) ? 0 : ( (x >= maxX) ? (maxX - 1) : x );
  y = (y < 0) ? 0 : ( (y >= maxY) ? (maxY - 1) : y );
  return (x + y * maxX);
}