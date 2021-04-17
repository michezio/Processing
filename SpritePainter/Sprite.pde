class Sprite
{
	int size;
  int sizeBackup;
	float blockSize;
	boolean showGrid;
	ArrayList<Block> block;
  ArrayList<Block> backup;

	Sprite(int s)
	{
		showGrid = true;
    size = s;
    sizeBackup = size;
    blockSize = height/float(size);
    backup = new ArrayList<Block>();
    block = new ArrayList<Block>();
    for (int x=0; x<size; ++x)
      for (int y=0; y<size; ++y)
        block.add(new Block(x,y,blockSize));
	}

  void setGrid(int s)
  {
    sizeBackup = size;
    size = s;
    blockSize = height/float(size);
    block.clear();
    block = new ArrayList<Block>();
    for (int x=0; x<size; ++x)
      for (int y=0; y<size; ++y)
        block.add(new Block(x,y,blockSize));
  }

	void show()
	{
		if (showGrid)
		{
			stroke(0);
			strokeWeight(1);
		}
		else noStroke();

		for (Block B : block)
			B.show();
	}

  void save(PGraphics img)
  {
    img.beginDraw();
    img.noStroke();
      for (Block B : block)
        B.store(img);
    img.endDraw();
  }

	color getBlockColor(float x, float y)
	{
		int i = floor(x/blockSize);
		int j = floor(y/blockSize);
		return block.get(i*size+j).getColor();
	}

	void setBlockColor(float x, float y, color col)
	{
		int i = floor(x/blockSize);
		int j = floor(y/blockSize);
		block.get(i*size+j).setColor(col);
	}

  void clear()
  {
    for (int x=0; x<size; ++x)
      for (int y=0; y<size; ++y)
        block.get(x*size+y).setColor(color(255,0)); 
  }
  
  void newUndo()
  {
    backup.clear();
    for (Block B : block)
      backup.add(B);
  }
  
  void undo()
  {
    size = sizeBackup;
    blockSize = height/float(size);
    block.clear();
    for (Block B : backup)
      block.add(B);
  }
}

class Block
{
	float x;
	float y;
	float size;
	color col;

	Block(int xIndex, int yIndex, float dim)
	{
		size = dim;
		x = xIndex * size;
		y = yIndex * size;
		col = color(255,0);
	}

	void show()
	{
		fill(col);
		rect(x,y,size,size);
	}

	void setColor(color c)
	{
		col = c;
	}

	color getColor()
	{
		return col;
	}

  void store(PGraphics img)
  {
    img.fill(col);
    img.rect(x,y,size,size);
  }
}