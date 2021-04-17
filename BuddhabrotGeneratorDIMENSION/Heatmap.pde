void populateHeatmap(int[][] heatmap, int MIN_ITERS, int MAX_ITERS, int LIMITS)
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
  
  // Generate random points in the global interval and initialize z0 to 0
  float ca = random(XMIN,XMAX);
  float cb = random(YMIN,YMAX);
  float a = 0;
  float b = 0;
  
  if (DIMENSION == 2)
  {
    // Check if the random point lies inside the main lobe (cardioid) or 
    // in the second lobe (circle). If so exit from the procedure
    // This avoids the analysis of points that will never escape for sure.
    // The following check has been adapted from wikipedia Mandelbrot page.
    float cbb = cb*cb;
    float caa = ca-0.25;
    float q = caa*caa+cbb;
    q *= q + caa;
    if (q < 0.25*cbb || (ca+1)*(ca+1)+cbb < 0.0625) return;
  }
  
  PVector z = new PVector(0,0);
  PVector c = new PVector(ca,cb);

  // Count the number of iterations the point need to escape
  // To calculate fractional powers phasor notation is used
  // so that Z^d => Z<mag^d,heading*d>
  while (n < MAX_ITERS)
  {
    // Use the multibrot recursion: Z(n-1) = Z(n)^DIM + C
    z.setMag(pow(z.mag(),DIMENSION));
    z.rotate(z.heading()*(DIMENSION-1));
    z.add(c);
    if (z.magSq() >= THRESH) break;
    ++n;
  }
  
  // If the number of iterations made is between the range chosen
  // then re-execute the iteration and increase the heatmap density block
  // by 1 if a point of the escape route lies in that block
  if (n > MIN_ITERS && n < MAX_ITERS)
  {
    int k = 0;
    z.set(0,0);
    while (k <= n)
    {
      // Use Mandelbrot recursion again
      z.setMag(pow(z.mag(),DIMENSION));
      z.rotate(z.heading()*(DIMENSION-1));
      z.add(c);
 
      // Check if the point is inside the heatmap, if so map it
      // to the corresponding pixel and increase it by 1 if is under the limit
      // If limit is zero, consider as no limit.
      if (z.x > XMIN && z.x < XMAX && z.y > YMIN && z.y < YMAX)
      {
        float x = map(z.x,XMIN,XMAX,0,width-0.001);
        float y = map(z.y,YMIN,YMAX,0,height-0.001);
        if (LIMITS == 0 || heatmap[floor(x)][floor(y)] < LIMITS) ++heatmap[floor(x)][floor(y)];
        ++points;
      }
      ++k;
    }
  }
}