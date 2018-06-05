final int COUNT = 30;
final float SPEED = 3;
final float RAD = 80;
final float THRESH = 60;

Ball[] balls;

void setup()
{
	size(500,400);
	colorMode(HSB);
	balls = new Ball[COUNT];
  for (int i=0; i<COUNT; ++i)
    balls[i] = new Ball();
}

void draw()
{
  for (Ball B : balls) B.update();
	for (int x=0; x<width; ++x)
	{
		for (int y=0; y<height; ++y)
		{
			float d = 0;
			for (Ball B : balls)
			{
			 d += THRESH * B.r / dist(x, y, B.pos.x, B.pos.y);
       //d += THRESH * B.r / protodist(x, y, B.pos.x, B.pos.y);
			}
      set(x, y, color(constrain(d,0,1024)%256));
		}
	}
}

float protodist( float x1, float y1, float x2, float y2)
{
  return (abs(x1-x2)+abs(y1-y2));
}

class Ball
{
	PVector pos;
	PVector vel;
	float r;

	Ball ()
	{
		pos = new PVector(random(width), random(height));
		vel = new PVector(random(SPEED/10, SPEED), 0);
		vel.rotate(random(TWO_PI));
		r = random(RAD/5, RAD);
	}

	void update()
	{
		pos.add(vel);

		if (pos.x > width || pos.x < 0) vel.x *= -1;
		if (pos.y > height || pos.y < 0) vel.y *= -1;
	}

	void show()
	{
		stroke(0);
		noFill();
		ellipse(pos.x, pos.y, r, r);
	}
}