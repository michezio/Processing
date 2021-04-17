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
      stroke(this.R, this.G, this.B);
      noFill();
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
  float acc;
}
int Rstd = 155;
int Gstd = 155;
int Bstd = 155;
int Rvar = 100;
int Gvar = 100;
int Bvar = 100;
int bubblecount = 100;
Bubble[] list = new Bubble[bubblecount];
data[] control = new data[bubblecount];

void generateRandomData(int i_)
{
  control[i_] = new data();
  control[i_].x_pos = random(width + 180) - 90;
  control[i_].y_pos = height + random(height) + 90;
  control[i_].acc = -(random(height/200) + 1);
  int a = floor(random(80))+10;
  int R = Rstd + (floor(random(2*Rvar)) - Rvar);
  int G = Gstd + (floor(random(2*Gvar)) - Gvar);
  int B = Bstd + (floor(random(2*Bvar)) - Bvar);
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
    list[i].drawBubble(control[i].x_pos, control[i].y_pos+=control[i].acc);
    if (control[i].y_pos < -90) generateRandomData(i);
  }
}