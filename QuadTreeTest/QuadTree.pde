// Actual class implementation

class qtRectangle {
  float x;
  float y;
  float w;
  float h;
  boolean subdivided = false;

  qtRectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean contains(qtElement p) {
    return ( p.x <= this.x+this.w &&
         p.x > this.x-this.w &&
         p.y <= this.y+this.h &&
         p.y > this.y-this.h );
  }
}

class qtElement {  // VIRTUAL CLASS TO EXTEND FOR OBJECT TO WORK WITH QUADTREE
  float x;
  float y;

  qtElement(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class QuadTree {
  int capacity;
  qtRectangle boundary;
  QuadTree nw;
  QuadTree ne;
  QuadTree sw;
  QuadTree se;
  boolean subdivided;
  ArrayList<qtElement> elements;

  QuadTree(qtRectangle boundary, int capacity) {
    this.boundary = boundary;
    this.subdivided = false;
    this.capacity = capacity;
    this.elements = new ArrayList<qtElement>(capacity);
  }

  QuadTree(float w, float h, int capacity) {
    this(new qtRectangle(w/2, h/2, w/2, h/2), capacity);
  }

  void subdivide() {
    qtRectangle r = boundary;
    nw = new QuadTree(new qtRectangle(r.x - r.w/2, r.y - r.h/2, r.w/2, r.h/2), this.capacity);
    ne = new QuadTree(new qtRectangle(r.x + r.w/2, r.y - r.h/2, r.w/2, r.h/2), this.capacity);
    sw = new QuadTree(new qtRectangle(r.x - r.w/2, r.y + r.h/2, r.w/2, r.h/2), this.capacity);
    se = new QuadTree(new qtRectangle(r.x + r.w/2, r.y + r.h/2, r.w/2, r.h/2), this.capacity);

    for (qtElement p : elements) {
      if (nw.insert(p)) continue;
      if (ne.insert(p)) continue;
      if (sw.insert(p)) continue;
      if (se.insert(p)) continue;
    }

    subdivided = true;
    //elements.clear();
  }

  boolean insert(qtElement p) {
    if (!boundary.contains(p)) return false;

    if (elements.size() < capacity) {
      elements.add(p);
      return true;
    }

    if (!subdivided) subdivide();

    if (nw.insert(p)) return true;
    if (ne.insert(p)) return true;
    if (sw.insert(p)) return true;
    if (se.insert(p)) return true;

    // if can't be inserted (?)
    return false;
  }

  void show() {
    stroke(0);
    noFill();
    rectMode(CENTER);

    if (!subdivided) {
      rect(boundary.x, boundary.y, boundary.w*2, boundary.h*2);
    }
    else {
      nw.show();
      ne.show();
      sw.show();
      se.show();
    }
  }
}