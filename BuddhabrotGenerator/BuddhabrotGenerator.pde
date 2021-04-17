/** 
*
*    BUDDHABROT GENERATOR
*    by Michele Abruzzese (@michezio_)
*    20.10.2017
*    
*    Generates a Buddhabrot fractal using a large number of points
*    Can create up to 3 heatmap that can be used to color the final
*    image. Set iterations for each channel in the main loop.
*    For Nebulabrot use 50 blue, 500 green, 5000 red or proportionally.
*
**/

// Magnitude threshold, if mag > thresh then series diverges
final float THRESH = 4;

// Points per frame
final int PPF = 1000;

// Curve exponent as x^curve. 1 gives linear mapping, 2 quadratic and 0.5 square root
final float R_CURVE = 1;
final float G_CURVE = 1;
final float B_CURVE = 1;

// Range of point to check and draw
final float XMIN = -1.5;
final float XMAX = 0.75;
final float YMIN = -1.125;
final float YMAX = 1.125;

// If true uses RGB channels to make a colored image,
// if false uses only red channel to make a grey scale image.
final boolean COLOR = true;
// If false draws the AntiBuddhabrot density map
// (the path of the point that reach the bailout)
// if true draws the canonical Buddhabrot density map
// (the path of the point that escape before the bailout)
final boolean ANTI = false;
// Enable check on the cardioid, only in anti mode
final boolean CARDIOID = true;

int ctr = 0;
long points = 0;

int[][] heatmapR;
int[][] heatmapG;
int[][] heatmapB;
float[][] image;

void setup()
{
  frameRate(1000);
  size(500,500);   // Set heatmap size. Larger sizes need more points for good details
  background(0);
  
  heatmapR = new int[height][width];
  if (COLOR)
  {
    heatmapG = new int[height][width];
    heatmapB = new int[height][width];
  }
  image = new float[height][width];
  for (int i=0; i<height; ++i)
    for (int j=0; j<width; ++j)
    {
      heatmapR[i][j] = 0;
      if (COLOR)
      {
        heatmapG[i][j] = 0;
        heatmapB[i][j] = 0;
      }
      image[i][j] = 0.0;
    } 
}

void draw()
{  
  // For every frame generate PPF random points for each channel
  for (int i=0; i<PPF; ++i)
  {
    if (ANTI)
    {
      // SET RGB CHANNELS PARAMETERS FOR ANTIBUDDHABROT: ITERATIONS, OFFSET;
      /* RED */   populateHeatmap(heatmapR, 500, 0);
      if (COLOR)
      {
      /* GREEN */ populateHeatmap(heatmapG, 5000, 0);
      /* BLUE */  populateHeatmap(heatmapB, 1000, 0);
      }
    }
    else
    {
      // SET RGB CHANNELS PARAMETERS FOR BUDDHABROT: MIN_ITER, MAX_ITER, LIMIT (0 = unlimited), OFFSET;
      /* RED */   populateHeatmap(heatmapR, 0, 10000, 0, 0);
      if (COLOR)
      {
      /* GREEN */ populateHeatmap(heatmapG, 0, 1000, 0, 0);
      /* BLUE */  populateHeatmap(heatmapB, 0, 100, 0, 0);
      }
    }
  } 
  
  // Every 120 frames normalize the heatmap and print it out
  if (ctr%120 == 0)
  {
    // Find the max density value for a pixel in each heatmap
    float maxR = 1;
    float maxG = 1;
    float maxB = 1;
    for (int i=0; i<height; ++i)
    {
      float PmaxR = max(heatmapR[i]);
      if (PmaxR > maxR) maxR = PmaxR;
      if (COLOR)
      {
        float PmaxG = max(heatmapG[i]);
        if (PmaxG > maxG) maxG = PmaxG;
        float PmaxB = max(heatmapB[i]);
        if (PmaxB > maxB) maxB = PmaxB;
      }
    }
    
    // Normalize the heatmap and map it to a 8bit color value 
    // based on CURVE parameter
    for (int i=0; i<height; ++i)
      for (int j=0; j<width; ++j)
      {
        // The curve function is the following, with PointDensity as variable:
        // (PointDensity/MaxDensity)^CURVE : [0,1] -> [0,255]
        float R = map ( R_CURVE == 1 ? heatmapR[i][j]/maxR : pow(heatmapR[i][j]/maxR,R_CURVE), 0, 1, 0, 255);
        if (COLOR)
        {
          float G = map ( G_CURVE == 1 ? heatmapG[i][j]/maxG : pow(heatmapG[i][j]/maxG,G_CURVE), 0, 1, 0, 255);
          float B = map ( B_CURVE == 1 ? heatmapB[i][j]/maxB : pow(heatmapB[i][j]/maxB,B_CURVE), 0, 1, 0, 255);
          set(j,i,color(R,G,B));
        }
        else set(j,i,color(R));
      }
    println(points);
  }
  
  ++ctr;
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