class Cell
{
	int ix, iy;
	float cell_size;
	float x, y;
	color shade, border;

	Cell(int row, int col, float cs)
	{
		ix = col;
		iy = row;
		cell_size = cs;

		x = iy*cs;
		y = ix*cs;

		shade = color(255);
  	border = color(200);
	}

	void show()
	{
	  noFill();
		stroke(border);
		rect(x,y,cell_size,cell_size);
	}

  void show(color c)
  {
    fill(c);
    stroke(border);
    rect(x,y,cell_size,cell_size);
  }

	void setColor(color c)
	{
		shade = c;
	}

	void setBorder(color c)
	{
    border = c;
	}
}