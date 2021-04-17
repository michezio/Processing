class Bubble
{
  public
    Bubble(int dim_, int R_, int G_, int B_)
    { 
      this.dim = dim_;
      this.R = R_;
      this.G = G_;
      this.B = B_;
    };
    void drawBubble(float x_, float y_)
    {
      noStroke();
      fill(this.R, this.G, this.B);
      ellipse(x_, y_, this.dim, this.dim);
    }
  private
    int dim;
    int R, G, B;
}

class data
{
  float x_pos;
  float y_pos;
  float vel;
}

int bubblecount = 2000;
Bubble[] list = new Bubble[bubblecount];
data[] control = new data[bubblecount];

void generateRandomData(int i_)
{
  control[i_] = new data();
  control[i_].x_pos = random(width + 50) - 25;
  control[i_].y_pos = height + random(height) + 25;
  control[i_].vel = -random(height/150)-1;
  int a = floor(random(20))+5;
  int R = floor(random(200)+55);
  int G = floor(random(200)+55);
  int B = floor(random(200)+55);
  list[i_] = new Bubble(a, R, G, B);    
}

void setup()
{
  fullScreen();
  background(0);
  //size(1366,768);
  for (int i=0; i<bubblecount; i++) generateRandomData(i);   
}

void draw()
{
  background(0);
  for (int i=0; i<bubblecount; i++)
  {
    list[i].drawBubble(control[i].x_pos, control[i].y_pos+=control[i].vel);
    if (control[i].y_pos < -90) generateRandomData(i);
  }
}