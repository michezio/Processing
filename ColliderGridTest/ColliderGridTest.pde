boolean up, down, left, right;

Actor actor;
int time;

int LIFESPAN = 3;

Grid grid;

void setup()
{
  colorMode(HSB);
  
  grid = new Grid(20);
  //fullScreen();
  size(600,600);
  background(255);
  actor = new Actor();
  time = 0;
}

void draw()
{
  background(255);

  //grid.show();
  //grid.precisePlacement(actor);
  grid.loosePlacement(actor);
  grid.processActive();
  
  actor.display();
  
  //println(frameRate);
}

void keyPressed()
{
  if (key == 'w') up = true;
  if (key == 's') down = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
}

void keyReleased()
{
  if (key == 'w') up = false;
  if (key == 's') down = false;
  if (key == 'a') left = false;
  if (key == 'd') right = false;
}

void mousePressed()
{
  
}