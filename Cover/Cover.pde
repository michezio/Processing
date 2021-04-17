Button but1;
Button but2;
Button but3;

void setup()
{
  size(640,480);
  background(0);
  but1 = new Button(100,200, 30, 255,255,255);
  but2 = new Button(200,200, 40, 40,50,100);
  but3 = new Button(300,200, 50, 200,13,150);
}

void draw()
{
  background(0);
  but1.show();
  but2.show();
  but3.show();
}
 
void mouseClicked()
{
  but1.check();
  but2.check();
  but3.check();
}