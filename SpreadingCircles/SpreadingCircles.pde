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
  float x_acc;
  float y_acc;
}

int bubblecount = 2000;
Bubble[] list = new Bubble[bubblecount];
data[] control = new data[bubblecount];

void generateRandomData(int i_)
{
  control[i_] = new data();
  do
  control[i_].x_pos = random(width + 2*height) - height;
  while(control[i_].x_pos > -90 && control[i_].x_pos < width+90);
  do
  control[i_].y_pos = random(height + 2*width) - width;
  while(control[i_].x_pos > -90 && control[i_].x_pos < width+90);
  control[i_].x_acc = random(height/100) - height/200;
  control[i_].y_acc = random(height/100) - height/200;
  int a = floor(random(30))+5;
  int R = floor(random(200)+55);
  int G = floor(random(200)+55);
  int B = floor(random(200)+55);
  list[i_] = new Bubble(a, R, G, B);    
}

void setup()
{
  fullScreen();
  background(0);
  //size(640,480);
  for (int i=0; i<bubblecount; i++) generateRandomData(i);   
}

void draw()
{
  background(0);
  for (int i=0; i<bubblecount; i++)
  {
    list[i].drawBubble(control[i].x_pos+=control[i].x_acc, 
                       control[i].y_pos+=control[i].y_acc);
    if (control[i].y_pos < -90 && control[i].y_acc < 0) generateRandomData(i);
    else if (control[i].y_pos > height+90 && control[i].y_acc > 0) generateRandomData(i);
    else if (control[i].x_pos < -90 && control[i].x_acc < 0) generateRandomData(i);
    else if (control[i].x_pos > width+90 && control[i].x_acc > 0) generateRandomData(i);
  }
}