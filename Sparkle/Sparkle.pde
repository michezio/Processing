int dimension = 5;
int SPEED = 5;

ArrayList<Bouncer> elements;
PVector[] vels;
int counter;

void setup()
{
  colorMode(HSB);
  //fullScreen();
  size(640,480);
  background(255);
  
  elements = new ArrayList<Bouncer>();
  vels = new PVector[dimension];
  for (int i=0; i<dimension; i++)
    {
      vels[i] = new PVector(1,0);
      vels[i].rotate(i*TWO_PI/float(dimension));
      vels[i].mult(SPEED);
    }
}

void draw()
{
  background(255);
  if (elements.size() > 0)
  {
    for (Bouncer B : elements)
    {
      B.display();
    }
  }
  
  if (counter%10 == 0) 
  {
    create();
    print(elements.size());
    print(" - ");
    println(frameRate);
  }
  
  counter++;
  
  colorMode(RGB);
  LPFilter3();
  colorMode(HSB);
}

void mouseClicked()
{
  color col = color(random(255),255,255);
  float PHASE = random(TWO_PI/dimension);
  for (int i=0; i<dimension; i++)
    {
      PVector vel = new PVector(SPEED,0).rotate(i*TWO_PI/dimension + PHASE);
      elements.add(new Bouncer(10, col, mouseX, mouseY, vel));
    }
}

void create()
{
  color col = color(random(255),255,255);
  float PHASE = random(TWO_PI/dimension);
  for (int i=0; i<dimension; i++)
    {
      PVector vel = new PVector(SPEED,0).rotate(i*TWO_PI/dimension + PHASE);
      elements.add(new Bouncer(10, col, mouseX, mouseY, vel));
    }
}