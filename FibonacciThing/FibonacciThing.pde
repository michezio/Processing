Series r;
final int PAD = 10;
final int OPAC = 20;
final int MAX = 199;

void setup() {
  size(500,500);
  r = new Series(1000);
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

class Series {
	int[] series;
	int n;
	color col;
	int w;
	int h;

	Series(int n) {
		this.col = color(0);
		this.n = n;
		this.series = new int[n];
    this.w = width;
    this.h = height;
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
    float scale = this.w/(float)(MAX-1);
    noFill();
    strokeWeight(1);
    strokeCap(SQUARE);
    stroke(this.col);
    int a = 1;
    int b = 1;
		for (int i=1; i<n; ++i) {
			float center = (a+b)/2.0;
      float d = (abs(a-b));
			if (i % 2 == 0) arc(center*scale, 0, d*scale, d*scale, 0, PI);
			else arc(center*scale, 0, d*scale, d*scale, PI, TWO_PI);
      int t = a;
      a = (a + b) % MAX;
      b = t;
		}
	}
}