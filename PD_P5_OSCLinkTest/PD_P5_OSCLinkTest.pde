import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress pd;

Sliders sl;


void setup() {
  size(400,400);
  
  osc = new OscP5(this, 12000);
  pd = new NetAddress("127.0.0.1", 1000);
  
  sl = new Sliders();
}

void draw() {
  background(0);
  sl.show();
}

void mousePressed() {
  sl.mouseOver(true);
}

void mouseReleased() {
  sl.mouseOver(false);
}

void mouseDragged() {
  sl.updateValues();
  if (sl.changed1()) 
    osc.send(new OscMessage("/v1").add(sl.get1()), pd);
  if (sl.changed2())
    osc.send(new OscMessage("/v2").add(sl.get2()), pd);
  if (sl.changed3())
    osc.send(new OscMessage("/v3").add(sl.get3()), pd);
}
