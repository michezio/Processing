final float SIZE = 20;
final float SPACE = -0.5;
final float NS = 0.1;
final float NV = 0.05;

float side = SIZE * sqrt(3) / 2.0;
float heit = 3*SIZE/2.0;

int rows, cols;

float z = 0;

Triangle[][] grid;

void setup()
{
	size(500,500);

	rows = floor(height/heit) + 2;
	cols = floor(width/side) + 2;

	grid = new Triangle[rows][cols];

	for (int y=0; y<rows; ++y)
	{
		for (int x=0; x<cols; ++x)
		{
			int conf;
			if (y%2 == 0) conf = 0;
			else conf = 1;
			if (x%2 == conf) grid[y][x] = new Triangle(new PVector(x*side, y*heit), 0);
			else grid[y][x] = new Triangle(new PVector(x*side, y*heit-heit/3.0), PI);
		}
	}
}

void draw()
{
	background(0);
  z += NV;
	for (int y=0; y<rows; ++y)
	{
		for (int x=0; x<cols; ++x)
		{
			grid[y][x].show(color((noise(x*NS,y*NS,z*NS)*768)%256));
		}
	}

  //saveFrame();
}

class Triangle
{
	PVector pos;
	PVector[] verts;

	Triangle(PVector pos, float rotation)
	{
		verts = new PVector[3];
		for (int i=0; i<3; ++i)
		{
			verts[i] = new PVector(0, -(SIZE-SPACE));
			verts[i].rotate(i*TWO_PI/3.0+rotation);
			verts[i].add(pos);
		}
	}

	void show(color c)
	{
		noStroke();
		fill(c);
		beginShape();
			for (int i=0; i<3; ++i)
				vertex(verts[i].x,verts[i].y);
		endShape(CLOSE);
	}
}