final float INCLINE = -1.0;
final float SIZE = 12;
final int COUNT = 1000;
final int EXTENSION = 127;

Diagonal[] diag;

float shade = 0;

void setup()
{
	//size(1024,768);
  fullScreen();
	colorMode(HSB);
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
    float startx = -random(width);
		float starty = random(2*height)+width;
		float stopx = random(width)+startx;
		col = color((random(EXTENSION)+shade)%255,170,255);
		pts = new PVector[4];
		pts[0] = new PVector(startx,starty);
		pts[1] = new PVector(startx,starty+SIZE);
		pts[2] = new PVector(stopx, (stopx-startx)*INCLINE+starty+SIZE);
		pts[3] = new PVector(stopx, (stopx-startx)*INCLINE+starty);
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