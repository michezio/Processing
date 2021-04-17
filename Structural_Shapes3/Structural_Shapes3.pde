final int MOUSE_SPOT = 20;

Diagonal[] diag;

int COUNT = 100;
float SIZE = 12;
float shade = 0;
int offstart = -10;
float INCLINE = -1.0;
float EXTENSION = 255;

PVector mouseStart;
PVector mouseStop;

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
    pts = new PVector[4];
    pts[3] = new PVector(random(width),random(height));
    pts[2] = pts[3].copy().add(new PVector(0,SIZE));
    pts[0] = new PVector(offstart, (offstart-pts[3].x)*INCLINE+pts[3].y);
    pts[1] = pts[0].copy().add(new PVector(0,SIZE));

		col = color((random(EXTENSION)+shade)%255,170,255);
	}

  void updateColor()
  {
    col = color((random(EXTENSION)+shade)%255,170,255);
  }
  
  void updateSize()
  {
    pts[2] = pts[3].copy().add(new PVector(0,SIZE));
    pts[1] = pts[0].copy().add(new PVector(0,SIZE));
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

void newDiagonals()
{
  for (int i=0; i<COUNT; ++i)
    diag[i] = new Diagonal();
}

void keyPressed()
{
  if (key == 's')
  {
    saveFrame("image-####.png");
    return;
  }
  if (key == 'z')
  {
    --SIZE;
    if (SIZE < 1) SIZE = 1;
    for (Diagonal D : diag)
      D.updateSize();
  }
  if (key == 'x')
  {
    ++SIZE;
    for (Diagonal D : diag)
      D.updateSize();
  }
  if (key == 'v')
  {
    --COUNT;
    if (COUNT < 1) COUNT = 1;
    diag = new Diagonal[COUNT];
    newDiagonals();
  }
  if (key == 'b')
  {
    ++COUNT;
    diag = new Diagonal[COUNT];
    newDiagonals();
  }
  if (key == 'c') 
  {
    EXTENSION = random(255);
    shade = random(255);
    for (Diagonal D : diag)
      D.updateColor();
  }
  if (key == ' ') 
  {
    newDiagonals();
  }
}

void mousePressed()
{
  mouseStart = new PVector(mouseX,mouseY);
}

void mouseReleased()
{
  mouseStop = new PVector(mouseX,mouseY);
  
  if (dist(mouseStart.x, mouseStart.y, mouseStop.x, mouseStop.y) < MOUSE_SPOT)
    return;
  else
  {
    INCLINE = (mouseStop.y - mouseStart.y)/(mouseStop.x - mouseStart.x);
    if (mouseStop.x > mouseStart.x) offstart = -10;
    else offstart = width+10;
    
    for (int i=0; i<COUNT; ++i)
      diag[i] = new Diagonal();
  }
}