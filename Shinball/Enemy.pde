class Enemy
{  
  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  
  Enemy(float sx, float sy)                    // CREATE ENEMY AT A GIVEN POSITION
  {
    size = ESIZE;
    pos = new PVector(sx,sy);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void display()
  {
    update();
    fill(color(ENM,255,255));
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
    return (((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  float distance(Actor _obj)
  {
    return (((pos.x-_obj.pos.x)*(pos.x-_obj.pos.x))
               +((pos.y-_obj.pos.y)*(pos.y-_obj.pos.y)));
  }
  
  void accelerate(Actor _obj)
  { 
    acc = new PVector(_obj.pos.x - pos.x, _obj.pos.y - pos.y);
    acc.normalize();
    acc.mult(ACCELERATION);
  }
  
  boolean isTouching(Enemy _obj)                    
  {
    if (distance(_obj) < (size/2 + _obj.size/2)*(size/2 + _obj.size/2))
      return true;
    else return false;
  }
  
  void bounce()                          // BOUNCE FROM WALLS
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
  
  void bounce(Enemy _obj)                        // BOUNCE FROM OTHER ENEMIES
  {
    PVector spd = new PVector(_obj.pos.x - pos.x, _obj.pos.y - pos.y);
    spd.normalize();
    spd.mult(REACTION);
    _obj.vel.add(spd);
    vel.x -= spd.x;
    vel.y -= spd.y;
    PVector pp = new PVector( (_obj.pos.x+pos.x)/2 , (_obj.pos.y+pos.y)/2 ); 
    collisions.add(new Collision(pp,spd));
  }
}