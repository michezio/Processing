Bubble[] elements;
Bubble pointer;

int ballcount = 700;
float G = 20;
boolean flag = true;
float click = 1;
float P_mass = 500;

void setup()
{
  frameRate(30);
  fullScreen();
  
  //size(640,480);
  background(250);
  
  pointer = new Bubble(0, 1, P_mass, color(0), new PVector(mouseX, mouseY));
  elements = new Bubble[ballcount];  
  for (int i=0; i<ballcount; i++)
    elements[i] = new Bubble(i);   
}

void draw()
{
  background(250);
  pointer.position.x = mouseX;
  pointer.position.y = mouseY;
  
  for (int i=0; i<ballcount; i++)
  {
    elements[i].acceleration = new PVector(0,0);
    elements[i].accelerate(pointer);        
    if (elements[i].isTooFar())
      elements[i] = new Bubble(i); 
    elements[i].acceleration.mult(click);
    elements[i].acceleration.limit(1.5);
    
    elements[i].display();
  }  
}

void mouseClicked()
{
  flag = !flag;
  if (flag) click = 1;
  else click = -0.5;
}