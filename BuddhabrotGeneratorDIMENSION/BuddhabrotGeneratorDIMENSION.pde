/** 
*
*    BUDDHABROT GENERATOR -- MULTIBROT SET BASED
*    by Michele Abruzzese (@michezio_)
*    22.10.2017
*    
*    Generates a Buddhabrot density map based on Multibrot set fractal
*    This version uses PVector functions to work with complex numbers
*    so is limited to 1 heatmap to impact less on performance
*    since the main pole check is no more available for other powers
*
**/

// Magnitude threshold, if mag > thresh then series diverges
final int THRESH = 4;
// Power of the multibrot se (positive please)
final float DIMENSION = 7;

// Range of point to check and draw
final float XMIN = -1.3;
final float XMAX = 1.3;
final float YMIN = -1.3;
final float YMAX = 1.3;

long points = 0;

int[][] heatmap;
float[][] image;

void setup()
{
  frameRate(1000);
  size(500,500);   // Set heatmap size. Larger sizes need more points for good details
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
  // For every frame generate PPF random points for the heatmap
  boolean generated = false;
  for (int i=0; i<1000; ++i)
  {
    // SET HEATMAP PARAMETERS: MIN_ITER, MAX_ITER, LIMIT (0 = unlimited);
    populateHeatmap(heatmap, 0, 100, 0);
  }

  // Find the max density value for a pixel in heatmap
  float max = 1;
  for (int i=0; i<height; ++i)
  {
    float maxr = max(heatmap[i]);
    if (maxr > max) max = maxr;
  }
  
  // Normalize the heatmap and map it to a 8bit color value 
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
    {
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