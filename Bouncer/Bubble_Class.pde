class Bubble
{
  int mass;
  color shade;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float damping;
  float speed_damp = 0.99;
  
  Bubble()
  { 
    mass = floor(random(50)) + 10;
    shade = color(random(255), random(255), random(255));
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(20) - 10, random(20) - 10);
    acceleration = new PVector(0,0);
    damping = random(0.2) + 0.8;
  }
  
  void display()
  {
    update();
    noStroke();
    fill(shade);
    ellipse(position.x, position.y, mass, mass);
  }
  
  void update()
  {
    velocity.mult(speed_damp);
    velocity.add(acceleration);
    position.add(velocity);
    
    if (position.x > width - mass/2) 
    {
      position.x = width - mass/2;
      velocity.x *= -damping;
    }
    else if (position.x < mass/2)
    {
      position.x = mass/2;
      velocity.x *= -damping;
    }
    
    if (position.y > height - mass/2) 
    {
      position.y = height - mass/2;
      velocity.y *= -damping;
    }
    else if (position.y < mass/2)
    {
      position.y = mass/2;
      velocity.y *= -damping;
    }
  }
}