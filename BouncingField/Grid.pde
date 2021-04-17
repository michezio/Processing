class Grid
{
	Cell[][] cells;
	float cell_size;
	int size, vsize;
  ArrayList<Cell> activeCells;
  boolean border, highlight;

	Grid(int s)
	{
		size = s;
		cell_size = width/float(size);
		vsize = floor(height/cell_size);

    border = false;
    highlight = false;

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

	void loosePlace(Actor a)
	{
		int i = floor(a.pos.x/cell_size);
		int j = floor(a.pos.y/cell_size);

		activeCells.clear();
    
    activeCells.add(cells[j-1][i-1]);
    activeCells.add(cells[j-1][i]);
    activeCells.add(cells[j-1][i+1]);
    activeCells.add(cells[j][i-1]);
    activeCells.add(cells[j][i]);
    activeCells.add(cells[j][i+1]);
    activeCells.add(cells[j+1][i-1]);
    activeCells.add(cells[j+1][i]);
    activeCells.add(cells[j+1][i+1]);
	}

  void singlePositionCollider(Actor a)
  {
    float s = a.size/2.0;
    float ss = s*s;
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
          a.vel.y *= -1;
        }
      if (cells[j+1][i].active) // LOWER CELL, check for up collision
        if (a.pos.y + s >= cells[j+1][i].y)
        {
          a.pos.y = cells[j+1][i].y - s;
          a.vel.y *= -1;
        }
      if (cells[j][i-1].active) // LEFT CELL, check for right collision
        if (a.pos.x - s <= cells[j][i-1].x + cell_size)
        {
          a.pos.x = cells[j][i-1].x + cell_size + s;
          a.vel.x *= -1;
        }
      if (cells[j][i+1].active) // RIGHT CELL, check for left collision
        if (a.pos.x + s >= cells[j][i+1].x)
        {
          a.pos.x = cells[j][i+1].x - s;
          a.vel.x *= -1;
        }
        
      if (cells[j-1][i-1].active) // UPPER-LEFT CELL, check for point 2
        if (sqDist(a.pos, cells[j-1][i-1].points[2]) < ss)
        {
          PVector n = a.pos.copy();
          n.sub(cells[j-1][i-1].points[2]);
          a.reflect(n);
        }
      if (cells[j-1][i+1].active) // UPPER-RIGHT CELL, check for point 1
        if (sqDist(a.pos, cells[j-1][i+1].points[1]) < ss)
        {
          PVector n = a.pos.copy();
          n.sub(cells[j-1][i+1].points[1]);
          a.reflect(n);
        }
      if (cells[j+1][i-1].active) // LOWER-LEFT CELL, check for point 3
        if (sqDist(a.pos, cells[j+1][i-1].points[3]) < ss)
        {
          PVector n = a.pos.copy();
          n.sub(cells[j+1][i-1].points[3]);
          a.reflect(n);
        }
      if (cells[j+1][i+1].active) // LOWER-RIGHT CELL, check for point 0
        if (sqDist(a.pos, cells[j+1][i+1].points[0]) < ss)
        {
          PVector n = a.pos.copy();
          n.sub(cells[j+1][i+1].points[0]);
          a.reflect(n);
        }
    }
  }

	void checkCollision()
	{
		for (Cell C : activeCells)
    {
			if (highlight) C.show(color(0,255,255,50));
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
  
  float sqDist(PVector a, PVector b)
  {
    return (a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y);
  }
}