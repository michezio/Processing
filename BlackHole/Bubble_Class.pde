class Bubble
{
  int dim;
  float mass;
  color shade;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float damping;
  int number;
  
  Bubble(int _num)
  { 
    number = _num;
    dim = floor(random(10)) + 10;
    mass = 2*dim;
    shade = color(random(200)+55, random(200)+55, random(200)+55);
    do
    position = new PVector(random(3*width)-width, random(3*height)-height);
    while(position.x > 0 && position.x < width && position.y > 0 && position.y < height);
    velocity = new PVector(random(10) - 5, random(10) - 5);
    acceleration = new PVector(0,0);
    damping = 0.99;
  }
  
  Bubble(int _num, int _dim, int _mass, color _shade, PVector _pos)
  {
    number = _num;
    dim = _dim;
    mass = _mass;
    shade = _shade;
    position = _pos;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    damping = 1;
  }
  
  void display()
  {
    update();
    noStroke();
    fill(shade);
    ellipse(position.x, position.y, dim, dim);
    //fill(255);
    //text(number, position.x, position.y);
  }
  
   void display2()
  {
    stroke(shade);
    noFill();
    ellipse(position.x, position.y, dim, dim);
    //fill(255);
    //text(number, position.x, position.y);
  }
  
  void update()
  {
    velocity.mult(damping);
    velocity.add(acceleration);
    position.add(velocity);
  }
  
  boolean isTooFar()
  {
    if (position.x > 3*width - width ||
        position.x < -width ||
        position.y > 3*height - height ||
        position.y < -height) 
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
    acceleration.add(axel.mult(G*_grav.mass/(dist*dist)));
  }
}

float distance(PVector pos, PVector pos2)
  {
    return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
  }