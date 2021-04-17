float DIVISIONS = 40;
float BALANCE = 0.8;
color BKG = color(0,0,255);
color COLOR = color(255,155,0);
float UNIT;
float x=0, y=0;

void setup()
{
	size(500,500);
	background(BKG);
  frameRate(10000);

	UNIT = width/DIVISIONS;

  strokeWeight(2);
}

void draw()
{
  if ( y == 0 && x == 0) background(BKG);
  drawThing(x,y);
  
  x+=UNIT;
  if (x > width)
  {
    x=0;
    y+=UNIT;
  }
  if (y > height) y=0;  
}

void drawThing(float x, float y)
{
  stroke(COLOR);
	if (random(1) > BALANCE) line(x,y,x+UNIT,y+UNIT);
	else line(x+UNIT,y,x,y+UNIT);
}
