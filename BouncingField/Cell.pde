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