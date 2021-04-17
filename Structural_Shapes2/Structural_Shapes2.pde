final float INCLINE = -1.0;
final boolean FROM_RIGHT = true;
final float SIZE = 12;
final int COUNT = 100;
final int EXTENSION = 255;

Diagonal[] diag;

float shade = 0;
int offstart = -10;

void setup()
{
	//size(1024,768);
  fullScreen();
	colorMode(HSB);
  if (FROM_RIGHT) offstart = width+10;
  
	diag = new Diagonal[COUNT];
	for (int i=0; i<COUNT; ++i)
		diag[i] = new Diagonal();
}

void draw()
{
	background(40);
	for (Diagonal D : diag)
		D.show();
}

class Diagonal
{
	PVector[] pts;
	color col;

	Diagonal()
	{
    pts = new PVector[4];
    pts[3] = new PVector(random(width),random(height));
    pts[2] = pts[3].copy().add(new PVector(0,SIZE));
    pts[1] = new PVector(offstart, (offstart-pts[2].x)*INCLINE+pts[2].y);
    pts[0] = pts[1].copy().add(new PVector(0,-SIZE));

		col = color((random(EXTENSION)+shade)%255,170,255);
	}

  void updateColor()
  {
    col = color((random(EXTENSION)+shade)%255,170,255);
  }
  
	void show()
	{
		noStroke();
		fill(col);
		beginShape();
			for (PVector P : pts)
				vertex(P.x, P.y);
		endShape(CLOSE);
	}
} 

void keyPressed()
{
  if (key == 's') saveFrame("image-####.png");
  if (key == 'c') 
  {
    shade = random(255);
    for (Diagonal D : diag)
      D.updateColor();
  }
  if (key == ' ') 
  {
    for (int i=0; i<COUNT; ++i)
      diag[i] = new Diagonal();
  }
}