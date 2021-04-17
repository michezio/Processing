
final float GAP = 25;
final boolean RAINBOW = true;

ArrayList<Drop> drops;


void setup() {
  fullScreen();
  background(0);
  frameRate(15);
  colorMode(HSB);
  strokeWeight(4);
  drops = new ArrayList<Drop>();
}

void draw() {
  background(0, 15);
   
  drops.add(new Drop());
  
  for (int i=drops.size()-1; i>=0; --i) {
    Drop d = drops.get(i);
    d.update();
    if (!d.isAlive())
      drops.remove(i);
    else
      d.show();
  }
  
}


class Drop {
  int len;
  PVector first_pos;
  PVector pos;
  color col;
  
  Drop(int l, float x, float y, color c) {
    len = l;
    pos = new PVector(x, y);
    first_pos = pos.copy();
    col = c;
  }
  
  Drop() {
    this(
      int(random(height)),
      random(width),
      random(GAP),
      color(random(255),255,255)
    );
  }
  
  boolean isAlive() { return pos.y < len; }
  
  void update() {
    pos.y += GAP;
    // reset drop and make it black so it
    // removes its own trails (in OPENGL)
    if (!isAlive() && col != color(0)) {
      col = color(0);
      pos = first_pos;
    }
  }
  
  void show() {
    stroke(col);
    point(pos.x, pos.y);
  }
}