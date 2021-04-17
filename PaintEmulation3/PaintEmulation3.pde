int RED = 0;
int GREEN = 0;
int BLUE = 0;
int STROKE = 2;
int PANEL = 100;
boolean clk = false;
float xpos, ypos, xbk, ybk;
boolean active = false;
color baseColor;
int counter = 0;

class Pointer
{
  int posX;
  int posY;
  
  Pointer(int x, int y)
  {
    posX = x;
    posY = y;
  }
}

ArrayList<Pointer> updateList = new ArrayList<Pointer>();

void setup()
{
  noSmooth();
  size(800,480);
  background(255);
}

void draw()
{
  if (clk)
  {
    if (!active)
    {
      xbk = xpos = mouseX;
      ybk = ypos = mouseY;
      active = true;
    }
    else
    {
      xbk = xpos;
      ybk = ypos;
      xpos = mouseX;
      ypos = mouseY;
    }
    
    stroke(color(RED,GREEN,BLUE));
    strokeWeight(STROKE);
    line(xbk, ybk, xpos, ypos);
 
  }
  else active = false; 
}


void mousePressed()
{
  clk = true;
}

void mouseReleased()
{
  clk = false;
}

void keyPressed()
{
  if (key == 'q')  // RED
    { RED = 255; GREEN = 0; BLUE = 0; };
  if (key == 'w')  // YELLOW
    { RED = 255; GREEN = 255; BLUE = 0; };
  if (key == 'e')  // GREEN
    { RED = 0; GREEN = 255; BLUE = 0; };
  if (key == 'r')  // CYAN
    { RED = 0; GREEN = 255; BLUE = 255; };
  if (key == 't')  // BLUE
    { RED = 0; GREEN = 0; BLUE = 255; };
  if (key == 'y')  // MAGENTA
    { RED = 255; GREEN = 0; BLUE = 255; };
  if (key == 'u')  // BLACK
    { RED = 0; GREEN = 0; BLUE = 0; };
  if (key == 'i')  // GREY
    { RED = 127; GREEN = 127; BLUE = 127; };
  if (key == 'o')  // WHITE
    { RED = 255; GREEN = 255; BLUE = 255; };
  if (key == 'p')  // RANDOM
    { RED = floor(random(255)); GREEN = floor(random(255)); BLUE = floor(random(255)); };
    
  if (key == 'a')  // RED+
    RED = (RED+10 > 255) ? 255 : RED+10;
  if (key == 'z')  // RED-
    RED = (RED-10 < 0) ? 0 : RED-10;
  if (key == 's')  // GREEN+
    GREEN = (GREEN+10 > 255) ? 255 : GREEN+10;
  if (key == 'x')  // GREEN-
    GREEN = (GREEN-10 < 0) ? 0 : GREEN-10;  
  if (key == 'd')  // BLUE+
    BLUE = (BLUE+10 > 255) ? 255 : BLUE+10;
  if (key == 'c')  // BLUE-
    BLUE = (BLUE-10 < 0) ? 0 : BLUE-10;  
    
  if (key == 'g') // SIZE+
    STROKE = (STROKE+1 > 40) ? 40 : STROKE+1;
  if (key == 'b') // SIZE-
    STROKE = (STROKE-1 < 0) ? 0 : STROKE-1;
    
  if (key == 'm') // FLOOD STACK
  {
    baseColor = get(mouseX,mouseY);
    updateList.add(new Pointer(mouseX, mouseY));
    while (!updateList.isEmpty())
    {
      Pointer P = updateList.remove(0);
      floodFill(P.posX,P.posY);
    }
  }
  
  if (key == 'n') // FLOOD RECURSIVE
  {
    baseColor = get(mouseX,mouseY);
    floodFillRec(mouseX,mouseY);
    counter = 0;
  }  
}