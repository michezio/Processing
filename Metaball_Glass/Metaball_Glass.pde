final int COUNT = 20;
final float SPEED = 0.5;
final float RAD = 100;
final float THRESH = 50;

Ball[] balls;

void setup()
{
	size(500,500);
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
				//d += THRESH * B.r / dist(x, y, B.pos.x, B.pos.y);
        d += THRESH * B.r / protodist(x, y, B.pos.x, B.pos.y);
			}
      set(x, y, color(map(d,0,255,255,0)));
		}
	}
  //filter(BLUR,1);
  //saveFrame();
}

float protodist( float x1, float y1, float x2, float y2)
{
  return (abs(x1-x2)-abs(y1-y2));
}

class Ball
{
	PVector pos;
	PVector vel;
	float r;

	Ball ()
	{
		pos = new PVector(random(3*width)-width, random(3*height)-height);
		vel = new PVector(random(SPEED/10, SPEED), 0);
		vel.rotate(random(TWO_PI));
		r = random(RAD/5, RAD);
	}

	void update()
	{
		pos.add(vel);

		if (pos.x > 2*width || pos.x < -width) vel.x *= -1;
		if (pos.y > 2*height || pos.y < -height) vel.y *= -1;
	}

	void show()
	{
		stroke(0);
		noFill();
		ellipse(pos.x, pos.y, r, r);
	}
}