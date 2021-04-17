Bubble[] elements;
Bubble pointer;

int ballcount = 15;
float G = 50;
float P_mass = 200;
float N_mass = -1;
float P_dim = 30;
float N_dim = 20;
color P_color = color(255,0,0);
color N_color = color(100,100,255);
int k = 0;

void setup()
{
  frameRate(30);
  fullScreen();
  
  //size(640,480);
  background(0);
  
  pointer = new Bubble();
  elements = new Bubble[ballcount];  
  for (k=0; k<ballcount; k++)
    elements[k] = new Bubble(k, new PVector(random(10), 0));   
}

void draw()
{
  background(0);
  pointer.position.x = mouseX;
  pointer.position.y = mouseY;
  pointer.display();
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration = new PVector(0,0);
    elements[i].accelerate(pointer);
    //for (int j=0; j<ballcount; j++)
      //if (j != i) elements[i].accelerate(elements[j]);
    if (elements[i].isTooFar() || elements[i].isTouching(pointer))
      elements[i] = new Bubble(++k, new PVector(random(10), 0)); 
    //elements[i].acceleration.limit(20);
    
    elements[i].display();
  }  
}