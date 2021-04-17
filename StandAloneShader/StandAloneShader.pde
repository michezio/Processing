final String name = "spiraling.glsl";

PShader s;

void setup() {
  size(600,600,P2D);
  s = loadShader(name);
}

void draw() {
  if (frameCount % 100 == 0) s = loadShader(name);
  s.set("time", (float)millis()/1000);
  
  filter(s);
}
