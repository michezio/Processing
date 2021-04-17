/** 
*
*    BUDDHABROT GENERATOR -- REAL TIME VERSION
*    by Michele Abruzzese (@michezio_)
*    20.10.2017
*    
*    Generates a Buddhabrot fractal using a large number of points
*    The RT version uses only 1 heatmap (Grey scale image) but allows
*    the visualization of each point as it gets calculated.
*    Useful to create high detailed images and to make screenshots.
*
**/

final int THRESH = 4; // Magnitude threshold, if mag > thresh then series diverges
final int MIN_ITER = 500; // Minimum iteration allowed for draw
final int MAX_ITER = 1000; // Maximum iteration allowed for draw
final int LIMIT = 10; // Single point heat limit

// Range of point to check and draw
final float XMIN = -2;
final float XMAX = 1;
final float YMIN = -1.5;
final float YMAX = 1.5;

long points = 0;

int[][] heatmap;
float[][] image;

void setup()
{
  frameRate(1000);
  size(800,800);   // Set heatmap size. Larger sizes need more points for good details
  background(0);
  
  heatmap = new int[height][width];
  image = new float[height][width];
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
    {
      heatmap[i][j] = 0;
      image[i][j] = 0.0;
    } 
}

void draw()
{  
  // For every frame generate PPF random points for each channel
  boolean generated = false;
  while (!generated)
  {
    generated = populateHeatmap(heatmap, MIN_ITER, MAX_ITER, LIMIT);
  }

  // Find the max density value for a pixel in each heatmap
  float max = 1;
  for (int i=0; i<height; ++i)
  {
    float maxr = max(heatmap[i]);
    if (maxr > max) max = maxr;
  }
  
  // Normalize the heatmap and map it to a 8bit color value 
  // based on CURVE parameter
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
    {
      // The curve function is the following, with PointDensity as variable:
      // (PointDensity/MaxDensity)^CURVE : [0,max] -> [0,255]
      float W = map ( heatmap[i][j], 0, max, 0, 255);
      set(j,i,color(W));
    }
  println(points);
}

void keyPressed()
{
  if (key == ' ')
    saveFrame();
    
  if (key == 'g')
  {
    filter(BLUR,1);
    saveFrame();
  }
}
