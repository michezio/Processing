int PTS = 1024;
int LMARGIN = 30;
int RMARGIN = 30;
int UMARGIN = 30;
int BMARGIN = 30;
float FGAIN = 10;
float PGAIN = TWO_PI;

Graph graph1;
Graph graph2;
HSlider fsl1, fsl2, fsl3;
HSlider asl1, asl2, asl3;
HSlider psl1, psl2, psl3;
VSlider csl;
float[] modulator;
float[] carrier;

float freqc = 50;
float freq1 = 4.6;
float amp1 = 1;
float ph1 = 0;
float freq2 = 8;
float amp2 = 0.6;
float ph2 = PI/2;
float freq3 = 13;
float amp3 = 0.2;
float ph3 = PI/3;

void setup()
{
  size(640,480);
  background(150);
  BMARGIN = height - BMARGIN;
  RMARGIN = width - RMARGIN;
  graph1 = new Graph(PTS, color(0,255,0), color(50,50,50), LMARGIN, UMARGIN, width-2*LMARGIN, height/2);
  graph2 = new Graph(PTS, color(0,0,255), color(0,100), LMARGIN, UMARGIN, width-2*LMARGIN, height/2);
  fsl1 = new HSlider( "Freq1", LMARGIN, BMARGIN-100, 100, 10, color(255,0,0) );
  asl1 = new HSlider( "Amp1", LMARGIN, BMARGIN-50, 100, 10, color(255,0,0) );
  psl1 = new HSlider( "Phase1", LMARGIN, BMARGIN, 100, 10, color(255,0,0) );
  fsl2 = new HSlider( "Freq2", LMARGIN+200, BMARGIN-100, 100, 10, color(0,255,0) );
  asl2 = new HSlider( "Amp2", LMARGIN+200, BMARGIN-50, 100, 10, color(0,255,0) );
  psl2 = new HSlider( "Phase2", LMARGIN+200, BMARGIN, 100, 10, color(0,255,0) );
  fsl3 = new HSlider( "Freq3", LMARGIN+400, BMARGIN-100, 100, 10, color(0,0,255) );
  asl3 = new HSlider( "Amp3", LMARGIN+400, BMARGIN-50, 100, 10, color(0,0,255) );
  psl3 = new HSlider( "Phase3", LMARGIN+400, BMARGIN, 100, 10, color(0,0,255) );
  csl = new VSlider( "Carrier", RMARGIN, BMARGIN-100, 100, 10, color(127,127,127) );
  modulator = new float[PTS];
  carrier = new float[PTS];
}

void draw()
{
  background(150);
  updateNumbers();
  graph1.show(carrier);
  graph2.show(modulator);
  fsl1.show();
  fsl2.show();
  fsl3.show();
  asl1.show();
  asl2.show();
  asl3.show();
  psl1.show();
  psl2.show();
  psl3.show();
  csl.show();
}

void updateNumbers()
{
  freq1 = FGAIN * fsl1.getValue();
  freq2 = FGAIN * fsl2.getValue();
  freq3 = FGAIN * fsl3.getValue();
  amp1 = asl1.getValue();
  amp2 = asl2.getValue();
  amp3 = asl3.getValue();
  ph1 = PGAIN * psl1.getValue();
  ph2 = PGAIN * psl2.getValue();
  ph3 = PGAIN * psl3.getValue();
  freqc = FGAIN * 5 * csl.getValue(); 
  
  float max1 = 0;
  for (int i=0; i<PTS; i++)
  {
    modulator[i] = sin(i*freq1*TWO_PI/PTS+ph1)*amp1
                 + sin(i*freq2*TWO_PI/PTS+ph2)*amp2
                 + sin(i*freq3*TWO_PI/PTS+ph3)*amp3;
    carrier[i] = sin(i*freqc*TWO_PI/PTS);
    if (abs(modulator[i]) > max1) max1 = abs(modulator[i]);
  } 
  for (int i=0; i<PTS; i++)
  {
    modulator[i]=modulator[i]/max1;
    carrier[i]*=modulator[i];
  }
}

void mousePressed()
{
  fsl1.mouseOver(true);
  fsl2.mouseOver(true);
  fsl3.mouseOver(true);
  asl1.mouseOver(true);
  asl2.mouseOver(true);
  asl3.mouseOver(true);
  psl1.mouseOver(true);
  psl2.mouseOver(true);
  psl3.mouseOver(true);
  csl.mouseOver(true);
}

void mouseReleased()
{
  fsl1.mouseOver(false);
  fsl2.mouseOver(false);
  fsl3.mouseOver(false);
  asl1.mouseOver(false);
  asl2.mouseOver(false);
  asl3.mouseOver(false);
  psl1.mouseOver(false);
  psl2.mouseOver(false);
  psl3.mouseOver(false);
  csl.mouseOver(false);
}