/*
Need to rethink the collision methods in the Grid class
The collision with the vertex of the square works almost
perfectly only if bounce is set to 1. Since the collision only
applyes translation and reflection on the current speed
of the object colliding it doesn't work properly if the
"collision" happens without a proper speed or when the object
is steady (eg. sliding along the edge). That's because every
frame the object appears as colliding so its speed gets reflected
every frame. If bounce is < 1 the object stucks to the corner.
*/

boolean up, down, left, right;

Actor actor;

Grid grid;

void setup()
{
  colorMode(HSB);
  
  grid = new Grid(10);
  //fullScreen();
  size(600,600);
  background(255);
  actor = new Actor();
  
  grid.generateMap(0.2);
  grid.setBounce(BOUNCE);
}

void draw()
{
  background(255);

  grid.show();
  //grid.loosePlace(actor);
  //grid.checkCollision(actor);
  actor.update();
  
  grid.singlePositionCollider(actor);
  
  actor.display();
  
  println(frameRate);
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP) up = true;
    if (keyCode == LEFT)
    {
      if (left) return;
      else { right = false; left = true; }
    }
    if (keyCode == RIGHT) 
    {
      if (right) return;
      else { left = false; right = true; }
    }
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
    if (keyCode == UP) up = false;
  }
}

void mousePressed()
{
  grid.cell(mouseX,mouseY).toggleActive();
}