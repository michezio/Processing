PVector[][] flowField;
PVector[][] flowField2;
int cols;
int rows;
Particle[] particles;
Particle[] particles2;
int c;

void setup()
{
  //size(800,600,P2D);
  fullScreen(P2D);
  background(BKGND);
  strokeCap(SQUARE);
  
  rows = width/SCALE;
  cols = height/SCALE;
  
  noiseSeed(floor(random(100)));
  flowField = new PVector[rows][cols];
  for (int i=0; i<rows; i++)
  {
    for (int j=0; j<cols; j++)
    {
      float n = noise(i*COMPLEXITY, j*COMPLEXITY)*TWO_PI*2;
      flowField[i][j] = PVector.fromAngle(n);
      flowField[i][j].setMag(MAG);
    }
  }
  noiseSeed(floor(random(100)));
  flowField2 = new PVector[rows][cols];
  for (int i=0; i<rows; i++)
  {
    for (int j=0; j<cols; j++)
    {
      float n = noise(i*COMPLEXITY, j*COMPLEXITY)*TWO_PI*2;
      flowField2[i][j] = PVector.fromAngle(n);
      flowField2[i][j].setMag(MAG);
    }
  }
  
  particles = new Particle[PARTCOUNT];
  for (int i=0; i<PARTCOUNT; i++)
    particles[i] = new Particle(COLOR1);
    
  particles2 = new Particle[PARTCOUNT];
  for (int i=0; i<PARTCOUNT; i++)
    particles2[i] = new Particle(COLOR2);
}

void draw()
{
  println(frameRate); 
  
  for (int i=0; i<rows; i++)
  {
    for (int j=0; j<cols; j++)
    {
      flowField[i][j].rotate(MUTATION);
      flowField2[i][j].rotate(-MUTATION);
    }
  }
  
  for (int i=0; i<PARTCOUNT; i++)
  {
    if (!particles[i].out && particles[i].life < LIFETIME) particles[i].show(flowField);
    else particles[i] = new Particle(COLOR1);
    if (!particles2[i].out && particles2[i].life < LIFETIME) particles2[i].show(flowField2);
    else particles2[i] = new Particle(COLOR2);
  }
}

void mouseClicked()
{
  saveFrame("PNG");
}