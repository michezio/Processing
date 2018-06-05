final float noisefreq = 0.02;
final float noisescale = 0.1;
final float noisespeed = 1;
final int points = 25;
final float amp = 300;
final int wavenum = 100;
final float size = 10;
final int opacity = 100;

final boolean fill = true;
final boolean record = false;

float t = 0;

ArrayList<Wave> waves;

void setup()
{
  waves = new ArrayList<Wave>();
  for (int i=0; i<wavenum; ++i)
    waves.add(new Wave(points, fill));
  
  colorMode(HSB);
  size (600,600,P3D);
  hint(ENABLE_STROKE_PERSPECTIVE);
  smooth(8);
}

void draw()
{  
  clear();
  
  camera(width/2.0, height/20.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
   
  for (int i=0; i<wavenum; ++i)
    waves.get(i).plot(t*noisescale,noisefreq*(i+1),noisescale*i);

  t += noisespeed;
  
  
  
  strokeWeight(size);
  
  
  PVector pos = new PVector();
  
  translate(width/2,300,100);
  
  if (fill) fill(0);
  else noFill();
  
  for (int i=0; i<wavenum; ++i)
  {
    float w = width+width/2.0*(i+1);
    color col = color(135,255,255,255-i*255/float(wavenum));
    pushMatrix();
      translate(-w/2.0,0,-i*8*height/float(wavenum));
      pos.set(0,0);
      waves.get(i).display(pos, col, amp, w);
    popMatrix();
  }
  
  
  if (record) saveFrame("####.gif");
}