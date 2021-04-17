Cube c, d, e;
ViewCam cam;

PVector mouseClick;

void setup() {
    size(800, 600, P3D);
    frameRate(1000);
    cam = createCam();

    c = createCube().setPosition(100, 0, 0).setFaceColor(color(255,0,0));
    d = createCube().setPosition(0, 100, 0).setFaceColor(color(0,255,0));
    e = createCube().setPosition(0, 0, 100).setFaceColor(color(0,0,255));

    mouseClick = new PVector(0, 0);
}

void draw() {
    hint(DISABLE_STROKE_PERSPECTIVE);
    background(20, 20, 20);

    // for (int i=0; i<10000; i++) {
    //     cam.rotate(0.0002,0.0001);
    // }

    cam.trasform();

    showAxis(cam.zoomScale);
    showGrid(50, cam.zoomScale);

    c.draw(cam.zoomScale);
    d.draw(cam.zoomScale);
    e.draw(cam.zoomScale);

    //if (frameCount % 60 == 0) println(frameRate);
}

void showGrid(float space, float scale) {
    int sub = floor(1000.0 / space);
    pushStyle();
    stroke(127, 100);
    strokeWeight(1/scale);
    for (int i=0; i<sub; i++) {
        line(-1000, 0, space * i, 1000, 0, space * i);
        line(-1000, 0, -space * i, 1000, 0, -space * i);
        line(space * i, 0, -1000, space * i, 0, 1000);
        line(-space * i, 0, -1000, -space * i, 0, 1000);
    }
    popStyle();
}

void showAxis(float scale) {
    pushStyle();
    stroke(255,0,0);
        strokeWeight(1/scale);
        line(-1000, 0, 0, 0, 0, 0);
        strokeWeight(3/scale);
        line(0, 0, 0, 1000, 0, 0);
    stroke(0,0,255);
        strokeWeight(1/scale);
        line(0, 0, -1000, 0, 0, 0);
        strokeWeight(3/scale);
        line(0, 0, 0, 0, 0, 1000);
    popStyle();
}