final int COUNT = 1;

boolean up, down, left, right;

ArrayList<Actor> actor;

Grid grid;

void setup()
{
  colorMode(HSB);
  
  grid = new Grid(20);
  //fullScreen();
  size(600,600,P3D);
  actor = new ArrayList<Actor>();
  for (int i=0; i<COUNT; ++i)
  {
    actor.add(new Actor());
    actor.get(i).pos = new PVector(random(width),random(height));
    actor.get(i).vel = new PVector(2,0).rotate(random(TWO_PI));
  } 
  
  grid.generateMap(0.2);
}

void draw()
{
  background(255);

  grid.show();
  //grid.loosePlace(actor);
  //grid.checkCollision(actor);
  for (Actor A : actor)
  {
    A.update();
    grid.singlePositionCollider(A); 
    A.display();
  }
  
  println(frameRate);
}

void keyPressed()
{
  if (key == 'w') up = true;
  if (key == 's') down = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
  
  if (key == 'b') grid.toggleBorder();
  if (key == 'h') grid.toggleHighlight();
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
  grid.cell(mouseX,mouseY).toggleActive();
}