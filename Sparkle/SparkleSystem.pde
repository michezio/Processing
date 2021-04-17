class SparkleSystem
{
  ArrayList<Bouncer> a;
  
  SparkleSystem(int _dim, PVector origin)
  {
    a = new ArrayList<Bouncer>();
    color col = color(random(255), random(255), random(255));
    float speed = random(20);
    for (int i=0; i<_dim; i++)
    {
      float vel_x = speed*cos(i*TWO_PI/_dim);
      float vel_y = speed*sin(i*TWO_PI/_dim);
      a.add(new Bouncer(10, col, origin, new PVector(vel_x, vel_y)));
    }
  }
  
  void display()
  {
    for (int i=0; i<a.size(); i++)
    {
      Bouncer b = a.get(i);
      b.display();
    } 
  }
}