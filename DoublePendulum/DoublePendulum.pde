final float g = 0.8;
final float damp = 0.9985;
final float hueshift = 0.2;

float hue;

float L1 = 120;
float L2 = 70;
float m1 = 20;
float m2 = 20;

float p1 = random(TWO_PI);
float p2 = random(TWO_PI);
float w1 = 0;
float w2 = 0;
float a1 = 0;
float a2 = 0;

float x1, x2, y1, y2;

PGraphics canvas;

void setup()
{
  size(600,600);
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.colorMode(HSB);
  canvas.strokeCap(SQUARE);
  canvas.background(0);
  canvas.strokeWeight(2);
  canvas.endDraw();
}

void draw()
{
  // println(totalEnergy());
  image(canvas,0,0);
  
  float px2 = x2;
  float py2 = y2;
  
  DoublePendulumFormula();
  
  w1 += a1;
  w2 += a2;
  w1 *= damp;
  w2 *= damp;
  p1 += w1;
  p2 += w2;
  
  x1 = L1 * sin(p1);
  y1 = L1 * cos(p1);
  x2 = x1 + L2 * sin(p2);
  y2 = y1 + L2 * cos(p2);
  
  translate(width/2.0, height/2.0);
  
  stroke(255);
  strokeWeight(4);
  fill(255);
  line(0,0,x1,y1);
  ellipse(x1,y1,m1,m1);
  line(x1,y1,x2,y2);
  ellipse(x2,y2,m2,m2);
  
  hue = (hue+hueshift)%255;
  canvas.beginDraw();
  canvas.stroke(hue,255,255,50);
  canvas.translate(width/2.0,height/2.0);
  if (frameCount > 1)
    canvas.line(px2,py2,x2,y2);
  canvas.endDraw();
}

void DoublePendulumFormula()
{
  // formulas extracted from https://www.myphysicslab.com/pendulum/double-pendulum-en.html
  
  float sinDiff = 2*sin(p1-p2);
  float cosDiff = cos(p1-p2);
  float den = 2*m1 + m2 - m2*cos(2*p1 - 2*p2);
  float ww1 = w1*w1;
  float ww2 = w2*w2;
  float msum = m1+m2;
   
  a1 = ( -g*(2*m1+m2)*sin(p1) - m2*g*sin(p1-2*p2) - sinDiff*m2*(ww2*L2+ww1*L1*cosDiff) ) / (L1 * den);
    
  a2 = ( sinDiff * (ww1*L1*msum + g*msum*cos(p1) + ww2*L2*m2*cosDiff) ) / (L2 * den);
}

float totalEnergy()
{
  // RECHECK THE FORMULAS
  
  float h1 = y1 - (L1);
  float h2 = y2 - (L1 + L2);
  float pot1 = m1*g*h1;
  float pot2 = m2*g*h2;
  float cin1 = 0.5*m1*w1*w1;
  float cin2 = 0.5*m2*w2*w2;
  
  return pot1+pot2+cin1+cin2;
}