import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

ArrayList<Stream> streamsB;
ArrayList<Stream> streamsBB;
ArrayList<Stream> streamsM;
ArrayList<Stream> streamsF;
PFont font;
PostFX bloom;

void setup()
{
  colorMode(HSB);
  size(800,600,P3D);
  //fullScreen(P2D);
  background(MATRIXCOLOR,200,20);
  streamsB = new ArrayList<Stream>();
  streamsBB = new ArrayList<Stream>();
  streamsM = new ArrayList<Stream>();
  streamsF = new ArrayList<Stream>();
  font = createFont("calibri", 32);
  textFont(font);
  textAlign(CENTER,TOP);
  bloom = new PostFX(this);
}

void draw()
{
  background(MATRIXCOLOR,200,10);
  if (random(1) > SPAWN-0.2)
    streamsBB.add( new Stream(random(width),random(-200,height-200), CHARSIZE-DISTANCE/2) );
  if (random(1) > SPAWN)
    streamsB.add( new Stream(random(width),random(-200,height-200), CHARSIZE) );
  if (random(1) > SPAWN+0.2)
    streamsM.add( new Stream(random(width),random(-200,height-200), CHARSIZE+DISTANCE) );
  if (random(1) > SPAWN+0.4)
    streamsF.add( new Stream(random(width),random(-200,height-200), CHARSIZE+2*DISTANCE) );
  
  for (int i=streamsBB.size()-1; i>=0; i--)
    {
      Stream S = streamsBB.get(i);
      if (!S.onScreen && S.list.size()<1)
        streamsBB.remove(i);
      else S.show();
    }
  for (int i=streamsB.size()-1; i>=0; i--)
    {
      Stream S = streamsB.get(i);
      if (!S.onScreen && S.list.size()<1)
        streamsB.remove(i);
      else S.show();
    }
  for (int i=streamsM.size()-1; i>=0; i--)
    {
      Stream S = streamsM.get(i);
      if (!S.onScreen && S.list.size()<1)
        streamsM.remove(i);
      else S.show();
    }
  for (int i=streamsF.size()-1; i>=0; i--)
    {
      Stream S = streamsF.get(i);
      if (!S.onScreen && S.list.size()<1)
        streamsF.remove(i);
      else S.show();
    }
    
  //fill(255);
  //textSize(20);
  //text(streamsB.size()+streamsM.size()+streamsF.size()+streamsBB.size(),100,30);
  //text(frameRate, 100, 60);
  
  bloom.render()
       .rgbSplit(40)
       .bloom(0.2,10,40)
       .compose();
}
