final float noisefreq = 0.5;
final float noisescale = 0.1;
final float noisespeed = 0.003;
final int points = 10;
final float amp = 200;
final int wavenum = 100;
final int echo = 20;
final int opacity = 200;
final int size = 2;

final boolean fill = true;
final boolean record = false;

float t = 0;

ArrayList<float[]> waves;

void setup()
{
  waves = new ArrayList<float[]>();
  for (int i=0; i<wavenum; ++i)
    waves.add(new float[points]);
  
  colorMode(HSB);
  size (600,600);
  smooth(8);
  background(0);
}

void draw()
{  
  println(frameRate);
  if (fill) fill(0);
  else fill(0,echo);
  noStroke();
  rect(0,0,width,height);
   
  int w = 0;
  for (float[] F : waves)
  {
    for (int i=0; i<points; ++i)
      F[i] = noise(i*noisefreq,w*noisescale,t)*amp;
    w++;
  }

  
  t += noisespeed;
  
  if (fill) fill(0);
  else noFill();
  
  strokeWeight(size);
  
  w = 0;
  int h = 1;
  for (float[] F : waves)
  {
    stroke(256.0/wavenum*w++,190,255,opacity);
    int x = 0;
    float offset = (height-amp)/(1.0+wavenum)*h;
    beginShape();
    curveVertex(0, F[0] + offset);
    for (float P : F) 
      curveVertex(width/(points-1.0)*x++, P + offset);
    curveVertex(width, F[points-1] + offset);
    if (fill)
    {
      vertex(width+10,F[points-1]+offset);
      vertex(width+10, height+10);
      vertex(-10, height+10);
      vertex(-10, F[0]+offset);
      endShape(CLOSE);
    }
    else endShape();
    h++;
  }
  
  if (record) saveFrame("####.gif");
}