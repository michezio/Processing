Cube createCube() {
    return new Cube(100.0);
}

class Cube {
    private float size;
    private float x, y, z;
    private float rx, ry, rz;
    private color faceColor, edgeColor;

    private Cube(float size) {
        this.size = size;
        this.x = this.y = this.z = 0;
        this.rx = this.ry = this.rz = 0;
        this.faceColor = color(127);
        this.edgeColor = color(0);
    }

    Cube setSize(float size) { this.size = size; return this; }
    Cube setPosition(float x, float y, float z) { this.x = x; this.y = y; this.z = z; return this; }
    Cube setRotation(float x, float y, float z) { this.rx = x; this.ry = y; this.rz = z; return this; }
    Cube setFaceColor(color c) { this.faceColor = c; return this; }
    Cube setEdgeColor(color c) { this.edgeColor = c; return this; }

    void draw(float scale) {
        pushStyle();
        pushMatrix();
        translate(x,y,z);
        rotateX(rx);
        rotateY(ry);
        rotateZ(rz);
        strokeWeight(1/scale);
        stroke(edgeColor);
        fill(faceColor);
        box(size, size, size);
        popMatrix();
        popStyle();
    }
}