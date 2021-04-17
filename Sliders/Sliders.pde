boolean usingslider = false;
VSlider slid1;
VSlider slid2;
HSlider slid3;

void setup()
{
  size(640,480);
  background(0);
  slid1 = new VSlider( "Speed", 100, 120, 200, 10, color(255,0,0) );
  slid2 = new VSlider( "Depth", 300, 120, 250, 10, color(0,255,0) );
  slid3 = new HSlider ( "Rate", 150, 50, 150, 10, color(0,0,255) );
}

void draw()
{
  background(0);
  slid1.show();
  slid2.show();
  slid3.show();
  fill(255);
  textSize(32);
  text(slid1.getValue(), 100, 350);
  text(slid2.getValue(), 300, 380);
  text(slid3.getValue(), 350, 50);
}

void mousePressed()
{
  slid1.mouseOver(true);
  slid2.mouseOver(true);
  slid3.mouseOver(true);
}

void mouseReleased()
{
  slid1.mouseOver(false);
  slid2.mouseOver(false);
  slid3.mouseOver(false);
}