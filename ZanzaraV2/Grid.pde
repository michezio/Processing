// GRID CLASS //////////////////////////////////////

class Grid
{
	Cell[][] cells;
	float cell_size;
	int size, vsize;
  ArrayList<Cell> activeCells;
  boolean border, highlight;
  float bounce;

	Grid(int s)
	{
		size = s;
		cell_size = width/float(size);
		vsize = floor(height/cell_size);

    border = false;
    highlight = false;
    bounce = 1;

		cells = new Cell[vsize][size];
    activeCells = new ArrayList<Cell>();

		for (int y=0; y<vsize; ++y)
		{
			for (int x=0; x<size; ++x)
			{
				cells[y][x] = new Cell(x, y, cell_size);
			}
		}
	}

	void show()
	{
		for (int y=0; y<vsize; ++y)
		{
			for (int x=0; x<size; ++x)
			{
				cells[y][x].show(border);
			}
		}
	}

	Cell cell(float x, float y)
	{
		int i = floor(x/cell_size);
		int j = floor(y/cell_size);

		return cells[j][i];
	}

  void singlePositionCollider(Actor a)
  {
    float s = a.size/2.0;
    
    int i = floor(a.pos.x/cell_size);
    int j = floor(a.pos.y/cell_size);
    
    if (cells[j][i].active)
    {
      PVector shift = a.pos.copy();
      shift.sub(cells[j][i].center);
      if (abs(shift.x) > abs(shift.y))
      {
        if (shift.x > 0) a.pos.x = cells[j][i].x + cell_size + s;
        else a.pos.x = cells[j][i].x - s;
      }
      else
      {
        if (shift.y > 0) a.pos.y = cells[j][i].y + cell_size + s;
        else a.pos.y = cells[j][i].y - s;
      }
    }
    else
    {
      if (cells[j-1][i].active) // UPPER CELL, check for low collision
        if (a.pos.y - s <= cells[j-1][i].y + cell_size)
        {
          a.pos.y = cells[j-1][i].y + cell_size + s;
          a.vel.y *= -bounce;
        }
      if (cells[j+1][i].active) // LOWER CELL, check for up collision
        if (a.pos.y + s >= cells[j+1][i].y)
        {
          a.pos.y = cells[j+1][i].y - s;
          a.vel.y *= -bounce;
        }
      if (cells[j][i-1].active) // LEFT CELL, check for right collision
        if (a.pos.x - s <= cells[j][i-1].x + cell_size)
        {
          a.pos.x = cells[j][i-1].x + cell_size + s;
          a.vel.x *= -bounce;
        }
      if (cells[j][i+1].active) // RIGHT CELL, check for left collision
        if (a.pos.x + s >= cells[j][i+1].x)
        {
          a.pos.x = cells[j][i+1].x - s;
          a.vel.x *= -bounce;
        }
        
      if (cells[j-1][i-1].active) // UPPER-LEFT CELL, check for point 2
        bounceCorner(cells[j-1][i-1],2,actor);
      if (cells[j-1][i+1].active) // UPPER-RIGHT CELL, check for point 1
        bounceCorner(cells[j-1][i+1],1,actor);
      if (cells[j+1][i-1].active) // LOWER-LEFT CELL, check for point 3
        bounceCorner(cells[j+1][i-1],3,actor);
      if (cells[j+1][i+1].active) // LOWER-RIGHT CELL, check for point 0
        bounceCorner(cells[j+1][i+1],0,actor);
    }
  }

  void bounceCorner(Cell c, int i, Actor a)
  {
    // CHECK THIS OUT, NON PERFECTLY WORKING
    
    float d = dist(a.pos.x, a.pos.y, c.points[i].x, c.points[i].y);
    if (d <= a.size/2.0)
    {
      PVector n = a.pos.copy();
      n.sub(c.points[i]).mult(-1);
      float dot = a.vel.dot(n);
      float sqmag = n.magSq();
      PVector nn = n.copy();
      n.setMag(abs(a.size/2.0-d));
      a.pos.sub(n);
      nn.mult(2*dot);
      nn.div(sqmag);
      a.vel.sub(nn);  
      a.vel.mult(bounce);
    }
  }

  void generateMap(float s)
  {
    for (int x=0; x<size; ++x)
    {
      for (int y=0; y<vsize; ++y)
      {
        if (x == 0 || x == size-1 || y == 0 || y == vsize-1) 
        {
          cells[y][x].toggleActive();
          cells[y][x].mutable = false;
        }
        else if (random(1) < s) cells[y][x].toggleActive();
      }
    }
  }
  
  void toggleBorder() { border = !border; }
  void toggleHighlight() { highlight = !highlight; }
  void setBounce(float b) { bounce = b; }
}

// CELL CLASS ///////////////////////////////////////////////////

class Cell
{
  int ix, iy;
  float cell_size;
  float x, y;
  color shade, border;
  boolean active;
  boolean mutable;
  PVector[] points;
  PVector center;

  Cell(int row, int col, float cs)
  {
    ix = col;
    iy = row;
    cell_size = cs;

    x = iy*cs;
    y = ix*cs;

    shade = color(100);
    border = color(200);
  
    mutable = true;
    active = false;
  }

  void show(boolean b)
  {
    if (active) fill(shade);
    else noFill();
    if (b) stroke(border);
    else noStroke();
    rect(x,y,cell_size,cell_size);
  }

  void show(color c)
  {
    fill(c);
    rect(x,y,cell_size,cell_size);
  }

  void toggleActive()
  {
    if (mutable) 
    {
      active = !active;
    
      if (active)
      {
        center = new PVector(x+cell_size/2.0, y+cell_size/2.0);
        points = new PVector[4];
        points[0] = new PVector(x,y);
        points[1] = new PVector(x,y+cell_size);
        points[2] = new PVector(x+cell_size,y+cell_size);
        points[3] = new PVector(x+cell_size,y);
      }
    }
  }
  
  void setColor(color c) { shade = c; }
  void setBorder(color c) { border = c; }
}