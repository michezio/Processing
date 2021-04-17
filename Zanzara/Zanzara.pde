Ball jumper;
Field objects;
boolean left, right;

void setup()
{
  size(640,480);
  background(255);
  jumper = new Ball();
  objects = new Field();
}

void draw()
{
  background(255);
  jumper.checkCollision(objects);
  jumper.show();
  objects.show();
}

void keyPressed() 
{
  if (key == 's') jumper.jump();
  if (key == 'd') right = true;
  if (key == 'a') left = true;
}

void keyReleased()
{
  if (key == 'd') right = false;
  if (key == 'a') left = false;
}

void mousePressed()
{
  objects = new Field();
}