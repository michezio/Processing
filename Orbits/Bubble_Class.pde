class Bubble
{
  float dim;
  float mass;
  color shade;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float damping;
  int number;
  
  //Bubble(int _num)
  //{ 
  //  number = _num;
  //  mass = floor(random(200)) + 10;
  //  dim = sqrt(mass);
  //  shade = color(random(255), random(255), random(255));
  //  do
  //  position = new PVector(random(3*width)-width, random(3*height)-height);
  //  while(position.x > 0 && position.x < width && position.y > 0 && position.y < height);
  //  velocity = new PVector(random(8) - 4, random(8) - 4);
  //  acceleration = new PVector(0,0);
  //  damping = 0.05;
  //}
  
  Bubble()
  {
    dim = P_dim;
    mass = P_mass;
    shade = P_color;
    position = new PVector(mouseX,mouseY);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    damping = 1;
  }
  
  Bubble(int i, PVector _vel)
  {
    number = i;
    dim = N_dim;
    mass = N_mass;
    shade = color(random(255), random(255), random(255));
    //do
    position = new PVector(0, random(height/3));
    //while(position.x > 0 && position.x < width && position.y > 0 && position.y < height);
    velocity = _vel;
    acceleration = new PVector(0,0);
    damping = 1;
  }
  
  void display()
  {
    update();
    noStroke();
    fill(shade);
    ellipse(position.x, position.y, dim, dim);
    fill(255);
    text(number, position.x+10, position.y-10);
  }
  
  void update()
  {
    //velocity.mult(1-(damping*damping));
    velocity.add(acceleration);
    position.add(velocity);
  }
  
  boolean isTooFar()
  {
    if (distance(this.position,new PVector(width/2, height/2)) > 3*height)
    {
      return true;
    }
    else return false;
  }
  
  boolean isTouching(Bubble _grav)
  {
    if (distance(position,_grav.position) < dim/2 + _grav.dim/2)
      return true;
    else return false;
  }
  
  void accelerate(Bubble _grav)
  { 
    PVector axel = new PVector(_grav.position.x - position.x,
                               _grav.position.y - position.y);
    axel.normalize();
    float dist = distance(position, _grav.position);
    axel.mult(G*_grav.mass/(dist*dist));
    acceleration.add(axel);
  }
}

float distance(PVector pos, PVector pos2)
  {
    return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
  }