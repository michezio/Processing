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
    dim = floor(random(10)) + 5;
    mass = 2*dim;
    shade = color(random(255), random(255), random(255));
    do
    position = new PVector(random(3*width)-width, random(3*height)-height);
    while(position.x > 0 && position.x < width && position.y > 0 && position.y < height);
    velocity = new PVector(random(20) - 10, random(20) - 10);
    acceleration = new PVector(0,0);
    damping = 0.7;
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
  
  void update()
  {
    velocity.add(acceleration);
    position.add(velocity);
    
    if (dim > 200) dim = 5;
    mass = 2*dim;
    
    velocity.limit(200/dim);
    
    if (position.x > width - dim/2) 
    {
      position.x = width - dim/2;
      velocity.x *= -damping;
    }
    else if (position.x < dim/2)
    {
      position.x = dim/2;
      velocity.x *= -damping;
    }
    
    if (position.y > height - dim/2) 
    {
      position.y = height - dim/2;
      velocity.y *= -damping;
    }
    else if (position.y < dim/2)
    {
      position.y = dim/2;
      velocity.y *= -damping;
    }
  }
}