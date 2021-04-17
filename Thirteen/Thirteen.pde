int startX, startY;
ArrayList<Enemy> enemies;
Actor actor;
int REF;
int BKG, ACT, ENM;
float highscore = 0;
PVector spawnPos;
int time, gap, timespan, foresee;

void setup()
{  
  //fullScreen();
  size(800,480);
  colorMode(HSB);
  
  setScreenDependency();
  
  enemies = new ArrayList<Enemy>();
  newGame();
}

void draw()
{
  background(BKG,255,255);
  timer();
  
  // SHOW SPAWN PLACE
  if (gap > foresee) 
  {
   noFill();
   stroke(ENM,255,255);
   strokeWeight(2);
   float siz = (timespan-gap)*SPAWN_AREA+ESIZE;
   ellipse(spawnPos.x,spawnPos.y,siz,siz);
  }
  
  
  
  // CICLE EVERY ENEMY AN CHECK CONDITIONS
  for (int i=0; i<enemies.size(); i++)
  {
    Enemy enemy = enemies.get(i);
    
    // CHECK OTHER ENEMIES FOR REBOUNCE
    for (int j=i+1; j<enemies.size(); j++)
    {
      Enemy nextenemy = enemies.get(j);
      if (enemy.isTouching(nextenemy)) enemy.bounce(nextenemy);
    }
    
    enemy.accelerate(actor);
    if (actor.isTouching(enemy)) newGame();
    enemy.display();
  }

  actor.display();
  
  if (SHOW_INFO) showInfo();
  // SHOW TOUCH ORIGIN
  if (actor.active && SHOW_TOUCH)
  {
    stroke(255);
    strokeWeight(1);
    noFill();
    ellipse(startX,startY,HS_DIM,HS_DIM);
    line(startX,startY,mouseX,mouseY);
  }
}

void timer()
{
  gap = ++time % (timespan);
  
  if (gap == foresee)
  {
    spawnPos.x = random(width);
    spawnPos.y = random(height);
  }
  if (gap == 0) enemies.add(new Enemy(spawnPos.x,spawnPos.y));
  
  // SHOW TIME AND HIGHSCORE
  float timer = time/float(FPS);
  fill(BKG,64,255);
  textSize(S_DIM);
  text(timer, S_DIM/3, HS_DIM+S_DIM);
  highscore = max(highscore, timer);  
  textSize(HS_DIM);
  text(highscore, S_DIM/3, HS_DIM);
  
}

void newGame()
{
  newPalette();
  background(BKG,255,255);
  if (height >= width)
  {
    actor = new Actor(width/2,3*height/4);
    spawnPos = new PVector(width/2, height/4);
  }
  else
  {
    actor = new Actor(3*width/4,height/2);
    spawnPos = new PVector(width/4, height/2);
  }
  enemies.clear();
  enemies.add(new Enemy(spawnPos.x,spawnPos.y));
  time = 0;
}



void mousePressed()
{
  actor.active = true;
  startX = mouseX;
  startY = mouseY;
}

void mouseReleased()
{
  actor.active = false;
}