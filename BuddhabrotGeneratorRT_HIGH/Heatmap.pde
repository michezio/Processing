import java.util.Random;

boolean populateHeatmap(int[][] heatmap, int MIN_ITERS, int MAX_ITERS, int LIMITS)
{
  /**
        Function to populate the heatmap of a channel based on the path
        a random starting point takes to diverge. Each pixel of the
        heatmap is increased if a point of the series lies inside it.
        ARGUMENTS:
        heatmap, the pointer to the heatmap we want to populate.
        MIN_ITERS, the minimum number of iteration a point need to do in order
                   to be included in the heatmap.
        MAX_ITERS, the maximum number of iteration a point can do to be considered
                   an escaping one (outside the Mandelbrot set).
        LIMITS, the maximum density a pixel can have. Use to avoid details shadowing.
  **/
  
  int n = 0;
  Random r = new Random();
  
  // Generate random points in the global interval and initialize z0 to 0
  double ca = XMIN + (r.nextDouble() * (XMAX - XMIN));
  double cb = YMIN + (r.nextDouble() * (YMAX - YMIN));
  double a = 0;
  double b = 0;
  
  // Check if the random point lies inside the main lobe (cardioid) or 
  // in the second lobe (circle). If so exit from the procedure
  // This avoids the analysis of points that will never escape for sure.
  // The following check has been adapted from wikipedia Mandelbrot page.
  double cbb = cb*cb;
  double caa = ca-0.25;
  double q = caa*caa+cbb;
  q *= q + caa;
  if (q < 0.25*cbb || (ca+1)*(ca+1)+cbb < 0.0625) return false;

  // Count the number of iterations the point need to escape
  while (n < MAX_ITERS)
  {
    // Use the Mandelbrot recursion: Z(n-1) = Z(n)^2 + C
    double aa = a*a - b*b;
    double bb = 2*a*b;
    a = aa + ca;
    b = bb + cb;
    
    if (a*a + b*b >= THRESH) break;
    ++n;
  }
  
  // If the number of iterations made is between the range chosen
  // then re-execute the iteration and increase the heatmap density block
  // by 1 if a point of the escape route lies in that block
  if (n > MIN_ITERS && n < MAX_ITERS)
  {
    int k = 0;
    a = 0;
    b = 0;
    while (k <= n)
    {
      // Use Mandelbrot recursion again
      double aa = a*a - b*b;
      double bb = 2*a*b;
      a = aa + ca;
      b = bb + cb;
 
      // Check if the point is inside the heatmap, if so map it
      // to the corresponding pizel and increase it by 1 if is under the limit
      // If limit is zero, consider as no limit.
      if (a > XMIN && a < XMAX && b > YMIN && b < YMAX)
      {
        float x = map((float)a,XMIN,XMAX,0,width-0.001);
        float y = map((float)b,YMIN,YMAX,0,height-0.001);
        if (LIMITS == 0 || heatmap[floor(x)][floor(y)] < LIMITS) ++heatmap[floor(x)][floor(y)];
        ++points;
      }
      ++k;
    }
    return true;
  }
  else return false;
}
