class QuadTree<T extends qtElement> {
  int capacity;
  qtRectangle boundary;
  QuadTree nw;
  QuadTree ne;
  QuadTree sw;
  QuadTree se;
  boolean subdivided;
  ArrayList<T> elements;

  QuadTree(qtRectangle boundary, int capacity) {
    this.boundary = boundary;
    this.subdivided = false;
    this.capacity = capacity;
    this.elements = new ArrayList<T>(capacity);
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

    for (T p : elements) {
      if (nw.insert(p)) continue;
      if (ne.insert(p)) continue;
      if (sw.insert(p)) continue;
      if (se.insert(p)) continue;
    }

    subdivided = true;
    elements.clear();
  }
  
  boolean contains(qtRectangle r, T p) {
    return ( (p.x <= r.x+r.w) && (p.x > r.x-r.w) && (p.y <= r.y+r.h) && (p.y > r.y-r.h) );
  }

  boolean insert(T p) {
    if (!p.isContained(boundary)) return false;
    // if (!contains(boundary, p)) return false;

    if (!subdivided && elements.size() < capacity) {
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

  boolean intersect(qtRectangle r1, qtRectangle r2) {
    return ( (abs(r1.x-r2.x) < r1.w+r2.w) && (abs(r1.y-r2.y) < r1.h+r2.h) );
  }
  
  boolean intersect(qtRectangle r, qtCircle c) {
    float sqDist = (r.x-c.x)*(r.x-c.x) + (r.y-c.y)*(r.y-c.y);
    float maxDist = c.r+2.8285*max(r.w,r.h);
    return ( sqDist < maxDist*maxDist );
  }

  ArrayList<T> query(qtRectangle range) {
    ArrayList<T> found = new ArrayList<T>();

    if (!intersect(boundary, range)) return found;

    if (!subdivided) {
      for (T p : elements) {
        if (p.isContained(range)) found.add(p);
      }
    }
    else {
      found.addAll(nw.query(range));
      found.addAll(ne.query(range));
      found.addAll(sw.query(range));
      found.addAll(se.query(range));
    }

    return found;
  }
  
  ArrayList<T> query(qtCircle range) {
    ArrayList<T> found = new ArrayList<T>();

    if (!intersect(boundary, range)) return found;

    if (!subdivided) {
      for (T p : elements) {
        if (p.isContained(range)) found.add(p);
      }
    }
    else {
      found.addAll(nw.query(range));
      found.addAll(ne.query(range));
      found.addAll(sw.query(range));
      found.addAll(se.query(range));
    }

    return found;
  }

  // Processing exclusive function, just for testing purposes
  void show(color c) {
    stroke(c);
    noFill();
    rectMode(CENTER);

    if (!subdivided) {
      rect(boundary.x, boundary.y, boundary.w*2, boundary.h*2);
    }
    else {
      nw.show(c);
      ne.show(c);
      sw.show(c);
      se.show(c);
    }
  }
}

// ---------------------------------------------------------------------------------------

class qtRectangle {
  float x;
  float y;
  float w;
  float h;

  qtRectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

// ---------------------------------------------------------------------------------------

class qtCircle {
  float x;
  float y;
  float r;
  
  qtCircle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
}

// ---------------------------------------------------------------------------------------

abstract class qtElement {  // VIRTUAL CLASS TO EXTEND FOR OBJECT TO WORK WITH QUADTREE
  float x;
  float y;
  
  qtElement(float x, float y) {
    this.x = x;
    this.y = y;
  }

  boolean isContained(qtRectangle r) {
    return ( (x <= r.x+r.w) && (x > r.x-r.w) && (y <= r.y+r.h) && (y > r.y-r.h) );
  }
  
  boolean isContained(qtCircle c) {
    float sqDist = (x-c.x)*(x-c.x) + (y-c.y)*(y-c.y);
    return ( sqDist < c.r*c.r );
  }
}
