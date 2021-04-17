class Carnivore
{
  PVector pos;
  PVector vel;
  float sight;
  float speed;
  float health;
  int age;
  int mature;
  int generation;
  int root;
  boolean selected;
  boolean searching;
  boolean generate;
  
  Carnivore(int r)
  {
    pos = new PVector(random(width),random(height));
    speed = random(SPEED_MUT*1.5);
    vel = new PVector(speed,0);
    vel.rotate(random(TWO_PI));
    sight = C_SIZE*2+random(SIGHT_MUT);
    health = C_HEL*C_PROL;
    age = 0;
    mature = 0;
    generation = 0;
    root = r;
  }
  
  Carnivore(Carnivore C)
  {
    pos = new PVector(C.pos.x,C.pos.y);
    speed = C.speed + random(-SPEED_MUT,SPEED_MUT);
    if (speed < 0) speed = 0;
    vel = new PVector(speed,0);
    vel.rotate(random(TWO_PI));
    sight = C.sight + random(-SIGHT_MUT,SIGHT_MUT);
    health = C_HEL*C_PROL;
    age = 0;
    mature = 0;
    generation = C.generation + 1;
    root = C.root;
  }
  
  void show()
  {
    noStroke();
    fill(0,255,255);
    ellipse(pos.x,pos.y,C_SIZE,C_SIZE);
    fill(255);
    textAlign(CENTER,CENTER);
    text(generation,pos.x,pos.y);
    stroke(255,20);
    noFill();
    ellipse(pos.x,pos.y,sight*2,sight*2);
  }
  
  void update()
  {
    pos.add(vel);
    if (pos.x > width+C_SIZE/2) pos.x = -C_SIZE/2;
    if (pos.x < -C_SIZE/2) pos.x = width+C_SIZE/2;
    if (pos.y > height+C_SIZE/2) pos.y = -C_SIZE/2;
    if (pos.y < -C_SIZE/2) pos.y = height+C_SIZE/2;
    if (TIME == 0)
    {
      if (health > C_HEL) health = C_HEL;
      if (health > C_HEL*C_PROL) mature++;
      else if (health < C_HEL*C_STRV && health > 0) mature--;
      if (mature == C_GEN)
      {
        generate = true;
        mature = 0;
      }
      health--;
    }
  }
  
  boolean seek(Herbivore H)
  {
    boolean stat = false;
    if (H.pos.x < pos.x + sight + H_SIZE/2 && H.pos.x > pos.x - sight - H_SIZE/2)
    {
      if (H.pos.y < pos.y + sight + H_SIZE/2 && H.pos.y > pos.y - sight - H_SIZE/2)
      {
        float d = distance(H);
        if (d < sight + F_SIZE/2)
        {
          vel.set(H.pos.x - pos.x, H.pos.y - pos.y);
          vel.normalize().mult(speed);
          if (d < (C_SIZE+H_SIZE)/2) stat = true;
        }
      }
    }
    else stat = false;
    
    return stat;
  }
  
  float distance(Herbivore H)
  {
    float xx = H.pos.x - pos.x;
    float yy = H.pos.y - pos.y;
    return sqrt(xx*xx + yy*yy);
  }
}