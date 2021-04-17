int xgrid = 10;
int ygrid = 10;
float xdim, ydim;
float incr = 0.02;

Square[][] sq;

void setup()
{
	size(500,500);
  xdim = width/float(xgrid);
  ydim = height/float(ygrid);
  
	sq = new Square[xgrid][ygrid];
  for (int x=0; x<xgrid; ++x)
    for (int y=0; y<ygrid; ++y)
      sq[x][y] = new Square(xdim, ydim, random(2), random(100), ceil(random(3)));
  
  background(0);
}

void draw()
{
	fill(0,20);
  noStroke();
  rect(0,0,width,height);
	stroke(255);
  for (int x=0; x<xgrid; ++x)
  {
    pushMatrix();
    for (int y=0; y<ygrid; ++y)
    {
      sq[x][y].show();
      sq[x][y].moveSeed(incr);
      translate(0, ydim);
    }
    popMatrix();
    translate(xdim, 0);
  }
}

void mouseClicked()
{
	for (int x=0; x<xgrid; ++x)
    for (int y=0; y<ygrid; ++y)
      sq[x][y] = new Square(xdim, ydim, random(2), random(100), ceil(random(3)));
}