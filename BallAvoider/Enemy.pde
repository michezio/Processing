float ACCELERATION = 0.3;
float SPEED_DAMP = 0.97;
float REACTION = 10;
float DISTANCE = 300;
float LAUNCH = 15;

class Enemy
{  
  PVector pos;
  PVector vel;
  PVector acc;
  color shade;
  float size = 20;
  
  Enemy()
  {
    int state = floor(random(4));
    vel = new PVector(0,0);
    switch (state)
    {
      case 0:
        pos = new PVector(size, size);
        vel.x = LAUNCH;
        vel.y = LAUNCH;
        break;
      case 1:
        pos = new PVector(size, height-size);
        vel.x = LAUNCH;
        vel.y = -LAUNCH;
        break;
      case 2:
        pos = new PVector(width-size, size);
        vel.x = -LAUNCH;
        vel.y = LAUNCH;
        break;
      case 3:
        pos = new PVector(width-size, height-size);
        vel.x = -LAUNCH;
        vel.y = -LAUNCH;
        break;
    }
    acc = new PVector(0,0);
  }
  
  void display()
  {
    update();
    fill(shade);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
  
  void update()
  {
    vel.add(acc);
    vel.mult(SPEED_DAMP);
    pos.add(vel);
    bounce();
  }
  
  float distance(Enemy _obj)
  {
    return sqrt(((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  float distance(Actor _obj)
  {
    float dist = sqrt(((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
                     +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
    if (dist > DISTANCE) shade = color(ENM,255,200);
    else shade = color(ENM,255,255);
    return dist;
  }
  
  void accelerate(Actor _obj)
  { 
    if (distance(_obj) < DISTANCE)
    {
      acc = new PVector(_obj.pos.x - pos.x, _obj.pos.y - pos.y);
      acc.normalize();
      acc.mult(ACCELERATION);
    }
    else acc.mult(0);
  }
  
  boolean isTouching(Enemy _obj)       // BOUNCE
  {
    if (distance(_obj) < size/2 + _obj.size/2)
      return true;
    else return false;
  }
  
  void bounce()
  {
    if (pos.y+size/2 > height)
    {
      pos.y = height - size/2;
      vel.y = -vel.y;
    }
    if (pos.y-size/2 < 0)
    {
      pos.y = size/2;
      vel.y = -vel.y;
    }
    if (pos.x+size/2 > width)
    {
      pos.x = width - size/2;
      vel.x = -vel.x;
    }
    if (pos.x-size/2 < 0)
    {
      pos.x = size/2;
      vel.x = -vel.x;
    }    
  }
  
  void bounce(Enemy _obj)
  {
    PVector spd = new PVector(_obj.pos.x - pos.x, _obj.pos.y - pos.y);
    spd.normalize();
    spd.mult(REACTION);
    _obj.vel.add(spd);
    vel.x -= spd.x;
    vel.y -= spd.y;
  }
}