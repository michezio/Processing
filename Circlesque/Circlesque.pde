final float DIM = 40;
final float RANGE = 0.5;
final String PALETTE = "spotify";
final int CONCENTRIC = 4;
final float OFFSET = sqrt(3)/2.0;
int dimx, dimy;
PGraphics grid;
Circle[][] c;
Palette pal;

void setup() {
	size(600,600);
	dimx = floor(width / (DIM*OFFSET)) + 2;
  dimy = floor(height / DIM) + 2;
  pal = generatePalette(PALETTE);  
	c = new Circle[dimx][];
	for (int i=0; i<dimx; ++i) {
		c[i] = new Circle[dimy];
		for (int j=0; j<dimy; ++j) {
			c[i][j] = new Circle(i*DIM*OFFSET, j*DIM+((i%2==1)?DIM/2.0:0), DIM, CONCENTRIC, pal);
		}
 	}
  drawGrid();
  background(pal.getBackground());
}

void draw() {
  noStroke();
  fill(pal.getBackground(),50);
  rect(0,0,width,height);
  translate(0, -DIM/2);
  image(grid,0,0);
	for (int i=0; i<dimx; ++i) {
    for (int j=0; j<dimy; ++j) {
      c[i][j].update();
	    c[i][j].display();
    }
  }
  println(frameRate);
}

void drawGrid() {
  grid = createGraphics(width + 2*(int)DIM, height + 2*(int)DIM);
  PVector[] a = new PVector[dimx*dimy];
  for (int i=0; i<dimx; ++i) {
    for (int j=0; j<dimy; ++j) {
      a[i+j*dimx] = c[i][j].pos;
    }
  }
  grid.beginDraw();
  grid.noFill();
  grid.strokeWeight(1);
  grid.stroke(pal.getAccent());
  for (int p1=0; p1 < a.length-1; ++p1) {
    for (int p2=p1; p2 < a.length; ++p2) {
      if (a[p1] == a[p2]) continue;
      else if (dist(a[p1].x, a[p1].y, a[p2].x, a[p2].y) <= DIM+1) {
        grid.line(a[p1].x, a[p1].y, a[p2].x, a[p2].y);
      }
    }
  }
  grid.endDraw();
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("image####.png");
    println("SAVED");
  }
}
