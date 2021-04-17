SandPile sp;
boolean adding = false;

void setup() {
	size(301,301);
  colorMode(HSB);
	sp = new SandPile(width, height);
	sp.initialize();
}

void draw() {
	sp.update(1000);
	sp.render();
  if (adding) sp.addGrain(mouseX, mouseY, 10000);
}

void mousePressed() {
  adding = true;
}

void mouseReleased() {
  adding = false;
}

class SandPile {
	int width;
	int height;
	int[] cell;

	SandPile(int width, int height) {
		this.width = width;
		this.height = height;
		cell = new int[width * height];
	}

	boolean update() {
    boolean changed = false;
		for (int y=0; y<this.height; ++y) {
			for (int x=0; x<this.width; ++x) {
        int c = cell[index(x,y)];
				if (c > 3) {
          changed = true;
					int spread = (int)c / 8;
					cell[index(x,y)] = c % 8;
					if (x != 0) {
            cell[index(x-1,y)] += spread;
            if (y != 0) cell[index(x-1,y-1)] += spread;
            if (y != height-1) cell[index(x-1,y+1)] += spread;
          }
					if (x != width-1) {
            cell[index(x+1,y)] += spread;
            if (y != 0) cell[index(x+1,y-1)] += spread;
            if (y != height-1) cell[index(x+1,y+1)] += spread;
          }
					if (y != 0) cell[index(x,y-1)] += spread;
					if (y != height-1) cell[index(x,y+1)] += spread;
				}
			}
		}
    return changed;
	}

  void update(int n) {
    for (int i=0; i<n; ++i) {
      if (!update()) return;
    }
  }
  
  void addGrain(int x, int y, int n) {
    cell[indexClip(x,y)] += n;  
  }
  
	void render() {
		loadPixels();
		for (int i=0; i<cell.length; ++i) {
      int c = cell[i];
			pixels[i] = color(map(c, 0, 7, 0, 255));
		}
		updatePixels();
	}


	void initialize() {
    cell[index(floor(width/2.0), floor(height/2.0))] = 300000;
	}

	int indexWrap(int x, int y) {
	  x = (x < 0) ? (width + x) : (x % width);
	  y = (y < 0) ? (height + y) : (y % height);
	  return (x + y * width);
	}

	int index(int x, int y) {
		return x + y * width;
	}

  int indexClip(int x, int y) {
    return index(constrain(x, 0, width-1), constrain(y, 0, height-1));
  }

}
