boolean up, down, left, right;
ArrayList<Enemy> enemies;
Actor actor;
int time;
int BKG, ACT, ENM;

int LIFESPAN = 3;

void setup()
{
  colorMode(HSB);
  BKG = floor(random(255));
  ACT = (BKG+127)%255;
  ENM = (ACT+64)%255;
  
  fullScreen();
  //size(800,600);
  background(BKG, 100, 100);
  actor = new Actor();
  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy());
  time = 0;
}

void draw()
{
  alpha(50);
  background(BKG, 100, 100);
  alpha(255);
  for (int i=0; i<enemies.size()-1; i++)
  {
    Enemy enemy = enemies.get(i);
    for (int j=i+1; j<enemies.size(); j++)
    {
      Enemy nextenemy = enemies.get(j);
      if (enemy.isTouching(nextenemy)) enemy.bounce(nextenemy);
    }
  }
  for (int i=0; i<enemies.size(); i++)
  {
    Enemy enemy = enemies.get(i);
    enemy.accelerate(actor);
    if (actor.isTouching(enemy)) endgame();
    enemy.display();
  }
  actor.display();
  timer();
}

void timer()
{
  time++;
  int gap = time % (60*LIFESPAN);
  int timer = time / 60;
  if (gap == 0) enemies.add(new Enemy());
  fill(255);
  textSize(32);
  text(timer,width-100, 50);
  text(enemies.size(), 100, 50);
}

void endgame()
{
  enemies.clear();
  enemies.add(new Enemy());
  time = 0;
}

void keyPressed()
{
  if (key == 'w')
    up = true;
  if (key == 's')
    down = true;
  if (key == 'a')
    left = true;
  if (key == 'd')
    right = true;
}

void keyReleased()
{
   if (key == 'w')
    up = false;
  if (key == 's')
    down = false;
  if (key == 'a')
    left = false;
  if (key == 'd')
    right = false;
}

void mouseClicked()
{
  BKG = floor(random(255));
  ACT = (BKG+127)%255;
  ENM = (ACT+64)%255;
}