class Square
{
	PVector pos;
	float w, h;
	int lines, pts;
	RandomWave[] line;
	float freq, seed;
	float vspan;

	Square(float x, float y, float w, float h, int lines, int pts, float freq, float seed)
	{
		this.pos = new PVector(x,y);
		this.w = w;
		this.h = h;
		this.lines = lines;
		this.pts = pts;
		this.freq = freq;
		this.seed = seed;
		this.vspan = h/lines;
		line = new RandomWave[lines];
		for (int i=0; i<lines; ++i)
		{
			line[i] = new RandomWave(pts, noise(i*freq+seed), freq);
			line[i].setScale(w/pts, h/lines);
		}
	}

	Square(float x, float y, float dim, float freq, float seed)
	{
		this(x, y, dim, dim, ceil(random(20)), 10, freq, seed);
	}

	Square(float dim, float freq, float seed)
	{
		this(0, 0, dim, freq, seed);
	}

  Square(float w, float h, float freq, float seed, int lines)
  {
    this(0, 0, w, h, lines, 10, freq, seed);
  }
  
  void moveSeed(float incr)
  {
    for (int l=0; l<lines; ++l)
      line[l].moveSeed(incr);
  }

	void show()
	{
		for (int l=0; l<lines; ++l)
		{
			pushMatrix();
			translate(0,l*vspan);
			line[l].show();
			popMatrix();
		}
	}
}



class RandomWave
{
	int pts;
	float scaleX, scaleY, seed, freq;

	RandomWave(int pts, float seed, float freq)
	{
		this.pts = pts;
		this.setSeed(seed, freq);
		this.setScale(1,1);
	}

	void setScale(float scaleX, float scaleY)
	{
		this.scaleX = scaleX;
		this.scaleY = scaleY;
	}

	void setSeed(float seed, float freq)
	{
		this.seed = seed;
		this.freq = freq;
	}

  void moveSeed(float incr)
  {
    this.seed += incr;
  }

	void show()
	{
		noFill();
		beginShape();
		curveVertex(0*scaleX, noise(0*freq, seed)*scaleY);
		for (int i=0; i<=pts; ++i)
			curveVertex(i*scaleX, noise(i*freq, seed)*scaleY);
		curveVertex((pts)*scaleX, noise((pts)*freq, seed)*scaleY);
		endShape();
	}
}