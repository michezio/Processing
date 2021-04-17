class Grid
{
	Cell[][] cells;
	float cell_size;
	int size, vsize;
  ArrayList<Cell> activeCells;

	Grid(int s)
	{
		size = s;
		cell_size = width/float(size);
		vsize = floor(height/cell_size);

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
				cells[y][x].show();
			}
		}
	}

	Cell cell(float x, float y)
	{
		int i = floor(x/cell_size);
		int j = floor(y/cell_size);

		return cells[j][i];
	}

	void precisePlacement(Actor a)
	{
		float hsize = a.size/2.0;
		// Up, Down, Right, Left
		boolean Uc = false, Dc = false, Rc = false, Lc = false;

		int i = floor(a.pos.x/cell_size);
		int j = floor(a.pos.y/cell_size);

		if (floor((a.pos.x+hsize+0.1)/cell_size)>i)
			Rc = true;
		if (floor((a.pos.x-hsize-0.1)/cell_size)<i)
			Lc = true;
		if (floor((a.pos.y+hsize+0.1)/cell_size)>j)
			Dc = true;
		if (floor((a.pos.y-hsize-0.1)/cell_size)<j)
			Uc = true;

    activeCells.clear();
    
    activeCells.add(cells[j][i]);
    if (Lc) activeCells.add(cells[j][i-1]);
    if (Rc) activeCells.add(cells[j][i+1]);
		if (Uc)
    {
      activeCells.add(cells[j-1][i]);
      if (Lc) activeCells.add(cells[j-1][i-1]);
      if (Rc) activeCells.add(cells[j-1][i+1]);
    }
		if (Dc)
    {
      activeCells.add(cells[j+1][i]);
      if (Lc) activeCells.add(cells[j+1][i-1]);
      if (Rc) activeCells.add(cells[j+1][i+1]);
    }
	}

  void loosePlacement(Actor a)
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

	void processActive()
	{
		for (Cell C : activeCells)
			C.show(color(0,50,255));
	}
}