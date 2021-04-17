class QuadGrid {
  int w, h;
  float s;
  float[][] grid;
  
  QuadGrid(float size) {
    s = size;
    w = ceil(width/size);
    h = ceil(height/size);
    
    grid = new float[h][w];
    
    for (int i=0; i<h; ++i)
      for (int j=0; j<w; ++j)
        disable(j, i);
  }
  
  void update(int x, int y, float var) {
    grid[y][x] = clip(grid[y][x] + var);
    if (grid[y][x] == 0) disable(x, y);
  }
  
  void set(int x, int y, float value) {
    grid[y][x] = clip(value);
  }
  
  void disable(int x, int y) {
    grid[y][x] = -1;
  }
  
  boolean isDisabled(int x, int y) {
    return grid[y][x] == -1;
  }
  
  float clip(float value) {
    return min(max(value, 0), 255);
  }
  
  int getX(float x) {
    return floor(x / s);
  }
  
  int getY(float y) {
    return floor(y / s);
  }
  
  float getFloat(float x, float y) {
    return grid[getY(y)][getX(x)];
  }
  
  void show(float hue) {
    for (int i=0; i<h; ++i) {
      for (int j=0; j<w; ++j) {
        if (isDisabled(j, i)) continue;
        fill(round(hue), 255, round(grid[i][j]));
        rect(j*s, i*s, s - MARGIN, s - MARGIN, CORNER_RADIUS);
        update(j, i, -FADE);
      }
    }
  }
}
