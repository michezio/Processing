Plot rt;
float[] d;

void setup() {
    size(500, 300);
    frameRate(10);
    d = new float[5];

    rt = new Plot();
}

void draw() {
    background(0);

    for (int i=0; i<d.length; i++) {
        d[i] = noise((frameCount + i)*0.1);
    }

    rt.setData(d)
      .setGridSpaceSamples(40, 32)
      .setLPF(1)
      .render(0, 0, width, height);
}

