Recaman r;
final int PAD = 10;
final int OPAC = 255;
final boolean WRAP = false;
final int MAX = 99;

void setup() {
  size(800,400);
  r = new Recaman(101);
  //noLoop();
}

void draw() {
  background(255);
  r.setLine(width-2*PAD, height-2*PAD, color(0,OPAC));
  translate(PAD, height/2);
  r.drawLine();
  //print(r.toString());
  noLoop();
}

class Recaman {
	int[] series;
	int max;
	int n;
	color col;
	int w;
	int h;

	Recaman(int n) {
		this.col = color(0);
		this.n = n;
		this.series = new int[n];
    this.w = width;
    this.h = height;
		int s = 0;
		this.max = 0;
		for (int i=0; i<n; ++i) {
			int min = s - i;
			boolean found = false;
			for (int j=0; j<i; ++j) {
				if (min < 0 || min == series[j]) {
					found = true;
					break;
				}
			}
			if (!found) this.series[i] = s = s - i;
			else this.series[i] = s = WRAP ? ((s + i) % MAX) : (s + i);
			if (s > this.max) this.max = s;
		}
	}

	String toString() {
		String s = "";
		for (int i=0; i<this.n; ++i) {
			s = s + " " + series[i];
		}
		return s;
	}


	void setLine(int w, int h, color col) {
		this.w = w;
    this.h = h;
		this.col = col;
	}

	void drawLine() {
    float scale = this.w/(float)this.max;
    //for (int i=0; i<this.max; ++i) {
    //  noStroke();
    //  fill(0);
    //  ellipse(i*scalex, 0, 2, 2);
    //}
    noFill();
    strokeWeight(1);
    strokeCap(SQUARE);
    stroke(this.col);
		for (int i=1; i<n; ++i) {
			float center = (series[i-1]+series[i])/2.0;
      float d = (abs(series[i-1]-series[i]));
			if (i % 2 == 0) arc(center*scale, 0, d*scale, d*scale, 0, PI);
			else arc(center*scale, 0, d*scale, d*scale, PI, TWO_PI);
		}
	}
}