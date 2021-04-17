float FREQ = 10;
float SPREAD = 0.4;
float SIZE = 20;
float OFFSET = 50;

void setup() {
    fullScreen();
    frameRate(15);
    colorMode(HSB);
    SPREAD = SPREAD * min(width, height);
    background(0);
}

void draw() {
    noStroke();
    fill(0, 20);
    rect(0, 0, width, height);

    int lim = int(random(FREQ));
    for (int i=0; i<lim; ++i)
        makePoint();
}

void makePoint() {
    float pox = OFFSET;
    float poy = height - OFFSET;
    if (random(1) > 0.5) {
        pox = width - OFFSET;
        poy = OFFSET;
    }
    pox += randomGaussian() * SPREAD;
    poy += randomGaussian() * SPREAD;
    strokeWeight(random(SIZE));
    stroke(random(255), 255, 255);
    point(pox, poy);
}