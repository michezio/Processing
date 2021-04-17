class Herbivore
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
  
  Herbivore(int r)
  {
    pos = new PVector(random(width),random(height));
    speed = random(SPEED_MUT);
    vel = new PVector(speed,0);
    vel.rotate(random(TWO_PI));
    sight = H_SIZE/2+random(SIGHT_MUT);
    health = H_HEL*H_PROL;
    age = 0;
    mature = 0;
    generation = 0;
    root = r;
  }
  
  Herbivore(Herbivore H)
  {
    pos = new PVector(H.pos.x,H.pos.y);
    speed = H.speed + random(-SPEED_MUT,SPEED_MUT);
    if (speed < 0) speed = 0;
    vel = new PVector(speed,0);
    vel.rotate(random(TWO_PI));
    sight = H.sight + random(-SIGHT_MUT,SIGHT_MUT);
    health = H_HEL*H_PROL;
    age = 0;
    mature = 0;
    generation = H.generation + 1;
    root = H.root;
  }
  
  void show()
  {
    noStroke();
    fill(170,255,255);
    ellipse(pos.x,pos.y,H_SIZE,H_SIZE);
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
    if (pos.x > width+H_SIZE/2) pos.x = -H_SIZE/2;
    if (pos.x < -H_SIZE/2) pos.x = width+H_SIZE/2;
    if (pos.y > height+H_SIZE/2) pos.y = -H_SIZE/2;
    if (pos.y < -H_SIZE/2) pos.y = height+H_SIZE/2;
    if (TIME == 0)
    {
      if (health > H_HEL) health = H_HEL;
      if (health > H_HEL*H_PROL) mature++;
      else if (health < H_HEL*H_STRV && health > 0) mature--;
      if (mature == H_GEN)
      {
        generate = true;
        mature = 0;
      }
      health--;
    }
  }
  
  int flee(Carnivore C)
  {
    int dang = 0;
    if (C.pos.x < pos.x + sight + C_SIZE/2 && C.pos.x > pos.x - sight - C_SIZE/2)
    {
      if (C.pos.y < pos.y + sight + C_SIZE/2 && C.pos.y > pos.y - sight - C_SIZE/2)
      {
        if (distance(C) < sight + C_SIZE/2)
        {
          vel.set(C.pos.x - pos.x, C.pos.y - pos.y);
          vel.normalize().mult(-speed);
          dang = 1;
        }
      }
    }
    else dang = 0;
    
    return dang;
  }
  
  boolean seek(Food F)
  {
    boolean stat = false;
    if (F.pos.x < pos.x + sight + F_SIZE/2 && F.pos.x > pos.x - sight - F_SIZE/2)
    {
      if (F.pos.y < pos.y + sight + F_SIZE/2 && F.pos.y > pos.y - sight - F_SIZE/2)
      {
        float d = distance(F);
        if (d < sight + F_SIZE/2)
        {
          vel.set(F.pos.x - pos.x, F.pos.y - pos.y);
          vel.normalize().mult(speed);
          if (d < (H_SIZE+F_SIZE)/2) stat = true;
        }
      }
    }
    else stat = false;
    
    return stat;
  }
  
  float distance(Carnivore C)
  {
    float xx = C.pos.x - pos.x;
    float yy = C.pos.y - pos.y;
    return sqrt(xx*xx + yy*yy);
  }
  
  float distance(Food F)
  {
    float xx = F.pos.x - pos.x;
    float yy = F.pos.y - pos.y;
    return sqrt(xx*xx + yy*yy);
  }
}