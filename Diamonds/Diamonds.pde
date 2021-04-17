import ch.bildspur.postfx.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;

final color BKGCOLOR = color(0);
final color ACCCOLOR = color(255);
final float MAXRADIUS = 40;
final float MAXVEL = 5;
final int MAXSIDES = 6;
final int COUNT = 1000;

ArrayList<RandomShape> shape;

PostFX aberr;

void setup()
{
  size(600,600,P3D);
  colorMode(HSB);
  smooth(8);
  strokeWeight(1);
  shape = new ArrayList<RandomShape>(COUNT);
  aberr = new PostFX(this);
}

void draw()
{
  background(BKGCOLOR);
  
  blendMode(EXCLUSION);
  for (RandomShape S : shape)
  {
    S.update();
    S.show();
  }
  
  blendMode(ADD);
  aberr.render()
       .bloom(0.9,int(40*noise(frameCount*0.1)),40)
       .rgbSplit(50*noise(frameCount*0.1))
       .compose();
}

void mouseDragged()
{
  shape.add(new RandomShape(mouseX, mouseY, MAXVEL,
                            round(random(3,MAXSIDES)), MAXRADIUS,
                            color(0,0,random(200,255))));
  
  if (shape.size() > COUNT) shape.remove(0);
}
