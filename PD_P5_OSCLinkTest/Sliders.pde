class Sliders {
  VSlider v1, v2, v3;
  float[] f1, f2, f3;
  
  Sliders() {
    v1 = new VSlider( "V1", 100, 100, 200, 20, color(255,0,0) );
    v2 = new VSlider( "V2", 200, 100, 200, 20, color(0,255,0) );
    v3 = new VSlider( "V3", 300, 100, 200, 20, color(0,0,255) );
    f1 = new float[2];
    f2 = new float[2];
    f3 = new float[2];
  }
  
  void show() {
    v1.show();
    v2.show();
    v3.show();
  }
  
  void mouseOver(boolean pressed) {
    v1.mouseOver(pressed);
    v2.mouseOver(pressed);
    v3.mouseOver(pressed);
  }
  
  void updateValues() {
    f1[1] = f1[0];
    f1[0] = v1.getValue();
    f2[1] = f2[0];
    f2[0] = v2.getValue();
    f3[1] = f3[0];
    f3[0] = v3.getValue();
  }
  
  boolean changed1() { return f1[0] != f1[1]; }
  boolean changed2() { return f2[0] != f2[1]; }
  boolean changed3() { return f3[0] != f3[1]; }
  float get1() { return f1[0]; }
  float get2() { return f2[0]; }
  float get3() { return f3[0]; }  
}
