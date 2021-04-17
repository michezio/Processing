final int circle = 400;
final int subs = 1000;
final float incr = TWO_PI/subs;
final float pow = 2;

final String series = "fibonacci";
int actual = 1;
int previous = 0;

PVector pos;
PVector offset;

int i = 0;
float hue = 0;

void setup()
{
  frameRate(1000);
  colorMode(HSB);
	size(800,800);
	background(255);
	noFill();
  stroke(0);
  strokeWeight(2); 	
	ellipse(width/2,height/2,2*circle,2*circle);
  strokeWeight(1);
  stroke(0,30);
  
	offset = new PVector(width/2,height/2);
	pos = new PVector(0,-circle);
}

void draw()
{
	int pRes = previous % subs;
	int aRes = actual % subs;

  float tanMult = abs(min(pRes-aRes,aRes-pRes))/float(subs);
  tanMult = pow(1-tanMult,pow);
  //println(tanMult);
  hue = ((1-tanMult) * 255 + 50) % 256;
  
	PVector pBase = pos.copy();
	pBase.rotate(pRes*incr);
	pBase.add(offset);
  
	PVector aBase = pos.copy();
	aBase.rotate(aRes*incr);
	aBase.add(offset);
  
  PVector pTan = pos.copy();
  pTan.mult(tanMult);
  pTan.rotate(pRes*incr);
  pTan.add(offset);
  
  PVector aTan = pos.copy();
  aTan.mult(tanMult);
  aTan.rotate(aRes*incr);
  aTan.add(offset);

  if (tanMult < 0.4) stroke(0,50);
  else stroke(color(hue%256,255,255),120);
  
  //line(pBase.x, pBase.y, aBase.x, aBase.y);
	bezier(pBase.x, pBase.y, pTan.x, pTan.y, aTan.x, aTan.y, aBase.x, aBase.y);
	nextNumber();
  
}

void nextNumber()
{
	switch (series)
	{
		case "fibonacci":
			int temp = previous + actual;
			previous = actual;
			actual = temp;
			break;
	}
}