class Field {
	int[][] g;
	Gradient x;
	int dimX, dimY;
	float width, height;
	float spanX, spanY;

	Field(int dimX, int dimY) {
		this.dimX = dimX;
		this.dimY = dimY;
		this.g = new int[dimX][dimY];	
		this.shuffle();
		this.x = new Gradient();
	}

	void setDimension(float width, float height) {
		this.width = width;
		this.height = height;
		this.spanX = width/dimX;
		this.spanY = height/dimY;
	}

	void show() {
    pushMatrix();
    translate(spanX/2,spanY/2);
		for (int i=0; i<dimX; ++i) {
			for (int j=0; j<dimY; ++j) {
        pushStyle();
        tint(255,random(100,200));
				x.show(i*spanX, j*spanY, spanX, spanY, g[i][j]*PI/2.0);
        popStyle();
			}
		}
    popMatrix();
	}

  void shuffle() {
    for (int i=0; i<dimX; ++i) {
      for (int j=0; j<dimY; ++j) {
        g[i][j] = floor(random(4));
      }
    }
  }
}

class Gradient {
	PGraphics g;

	Gradient(int width, int height) {
		g = createGraphics(width,height);
		g.beginDraw();
			g.loadPixels();
			for (int x=0; x<g.width; ++x) {
				float xx = map(x, 0, g.width-1, 0, 1);
				for(int y=0; y<g.height; ++y) {
					float yy = map(y, 0, g.height, 0, 1);
					g.pixels[x + y*g.width] = color(map(pow(xx*yy,1), 0, 1, 0, 255));
				}
			}
			g.updatePixels();
		g.endDraw();
	}

  Gradient() {
    this(50,50);
  }

	void show(float x, float y, float w, float h, float r) {
    pushMatrix();
    translate(x,y);
    rotate(r);
    imageMode(CENTER);
    image(g,0,0,w,h);
    popMatrix();
	}	

  void show(float x, float y, float r) {
    show(x,y,g.width,g.height,r);
  }
}