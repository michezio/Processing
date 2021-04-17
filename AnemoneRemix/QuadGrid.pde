class QuadGrid {
  Quad[][] grid;
  int w, h;
  float s;
  
  QuadGrid(float size) {
    s = size;
    w = ceil(width/size);
    h = ceil(height/size);
    float area_ratio = (size*size)/(width*height);
    int expected_size = round(COUNT*area_ratio);
    
    grid = new Quad[h][w];
    
    for (int i=0; i<h; ++i)
      for (int j=0; j<w; ++j)
        grid[i][j] = new Quad(expected_size);
  }
  
  void reset() {
    for (int i=0; i<h; ++i)
      for (int j=0; j<w; ++j)
        grid[i][j].reset();
  }
  
  void insert(Ball b) {
    grid[getY(b.p.y)][getX(b.p.x)].put(b);
  }
  
  ArrayList<Ball> query(float x, float y, float size) {
    ArrayList<Ball> res = new ArrayList<Ball>(getQuad(x, y).elements.size());
    int xx = getX(x);
    int yy = getY(y);
    size *= size;
    for (int i = -1; i <= 1; i++) {
      int yyy = yy + i;
      if (yyy < 0 || yyy >= h) continue;
      for (int j = -1; j <= 1; j++) {
        int xxx = xx + j;
        if (xxx < 0 || xxx >= w) continue;
        for (Ball b : grid[yyy][xxx].elements) {
          if (sqDist(b.p, new PVector(x, y)) <= size) 
            res.add(b);
        }
      }
    }
    return res;
  }
  
  int getX(float x) {
    return floor(x / s);
  }
  
  int getY(float y) {
    return floor(y / s);
  }
  
  Quad getQuad(float x, float y) {
    return grid[getY(y)][getX(x)];
  }
}



class Quad {
  ArrayList<Ball> elements;
  int expected_size;
  
  Quad(int size) {
    expected_size = size;
    reset();
  }
  
  void reset() {
    elements = new ArrayList<Ball>(expected_size);
  }
  
  void put(Ball b) {
    elements.add(b);
  }
  
  ArrayList<Ball> getElements() {
    return elements;
  }
}