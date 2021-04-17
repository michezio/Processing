float RED = 0;
float GREEN = 0;
float BLUE = 0;
int PANEL = 100;
int DIFF = 0;
int MAX_DIFF = 2000;
float STROKE = 1;
float MAX_STROKE = 40;

boolean clk = false;
boolean active = false;
boolean showpanel = false;
boolean clear = false;
boolean undoState = false;

color baseColor;
color toReplace = color(255,255,255);

int counter = 0;


color[][] imgUndo, imgRedo;

VSlider reds, greens, blues, strokes;
SButton redButton, greenButton, blueButton,
        yellowButton, cyanButton, magentaButton,
        whiteButton, greyButton, blackButton,
        customButton, pickedButton;
ToolPanel tools;

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
  size(780,480);
  background(255);
  imgUndo = new color[width-PANEL][height];
  imgRedo = new color[width-PANEL][height];
  for (int i=0; i<width-PANEL; i++)
    for (int j=0; j<height; j++)
      imgRedo[i][j] = imgUndo[i][j] = color(255,255,255);
  reds = new VSlider( "R", width-PANEL+20, 30, 100, 10, color(255,0,0) );
  greens = new VSlider( "G", width-PANEL+50, 30, 100, 10, color(0,255,0) );
  blues = new VSlider( "B", width-PANEL+80, 30, 100, 10, color(0,0,255) );
  strokes = new VSlider( "STROKE", width-PANEL+20, 340, 100, 10, color(200,200,200) );
  redButton = new SButton( width-PANEL+10, 180, 20, 20, color(255,0,0) );
  greenButton = new SButton( width-PANEL+40, 180, 20, 20, color(0,255,0) );
  blueButton = new SButton( width-PANEL+70, 180, 20, 20, color(0,0,255) );
  yellowButton = new SButton( width-PANEL+10, 210, 20, 20, color(255,255,0) );
  cyanButton = new SButton( width-PANEL+40, 210, 20, 20, color(0,255,255) );
  magentaButton = new SButton( width-PANEL+70, 210, 20, 20, color(255,0,255) );
  whiteButton = new SButton( width-PANEL+10, 240, 20, 20, color(255,255,255) );
  greyButton = new SButton( width-PANEL+40, 240, 20, 20, color(127,127,127) );
  blackButton = new SButton( width-PANEL+70, 240, 20, 20, color(0,0,0) );
  customButton = new SButton( width-PANEL+10, 270, 35, 20, color(0,0,0) );
  pickedButton = new SButton( width-PANEL+55, 270, 35, 20, color(0,0,0) );
  tools = new ToolPanel( 5, width-PANEL+40, 340, 50, 16, color(100,100,100) );
  tools.setNames(0, "PENCIL");
  tools.setNames(1, "AERO");
  tools.setNames(2, "BUCKET");
  tools.setNames(3, "REPLACE");
  tools.setNames(4, "FRACTAL");
}

void draw()
{
  if (clear) 
  {
    background(255);
    clear = false;
  }
  
  drawPanel();
  
  if (clk && tools.getTool() == "PENCIL")
  {
    if (!active) active = true;
    
    stroke(color(RED,GREEN,BLUE));
    strokeWeight(STROKE);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  else active = false; 
  
  if (clk && tools.getTool() == "AERO")
  {
    int dx = 0;
    int dy = 0;
    int ctr = 2;
    while (ctr-- != 0)
    {
      do
      {
        dx = floor(random(-STROKE,STROKE));
        dy = floor(random(-STROKE,STROKE));
      }
      while( sqrt(dx*dx+dy*dy) > STROKE);
      if (random(1) > 0.5)
        set(mouseX+dx, mouseY+dy, color(RED,GREEN,BLUE));
      if (random(1) > 0.5)
        set(mouseX-dx, mouseY-dy, color(RED,GREEN,BLUE));
      if (random(1) > 0.5)
        set(mouseX+dx, mouseY-dy, color(RED,GREEN,BLUE));
      if (random(1) > 0.5)
        set(mouseX-dx, mouseY+dy, color(RED,GREEN,BLUE));
    }
  }
  
  if (clk && tools.getTool() == "BUCKET")
  {
    baseColor = get(mouseX,mouseY);
    updateList.add(new Pointer(mouseX, mouseY));
    while (!updateList.isEmpty())
    {
      Pointer P = updateList.remove(0);
      floodFill(P.posX,P.posY);
    }
    clk = false;
  }
  
  if (clk && tools.getTool() == "FRACTAL")
  {
    baseColor = get(mouseX,mouseY);
    floodFillRec(mouseX,mouseY);
    counter = 0;
  }
  
  if (clk && tools.getTool() == "REPLACE")
  {
    float STRSQ = (STROKE*STROKE)/4;
    for (int i=ceil(-STROKE/2); i<=STROKE/2; i++)
      for (int j=ceil(-STROKE/2); j<=STROKE/2; j++)
      {
        if ( (i*i+j*j)<=STRSQ )
          if (get(mouseX+i,mouseY+j) == toReplace)
            set(mouseX+i, mouseY+j, color(RED,GREEN,BLUE));
      }
  }
    
}

void drawPanel()
{
  noStroke();
  fill(color(60,60,60));
  rect(width-PANEL,0,PANEL, height);
  
  reds.show();
  greens.show();
  blues.show();
  strokes.show();
  
  redButton.show();
  greenButton.show();
  blueButton.show();
  yellowButton.show();
  cyanButton.show();
  magentaButton.show();
  whiteButton.show();
  blackButton.show();
  greyButton.show();
  
  STROKE = MAX_STROKE*strokes.getValue();
  DIFF = floor(pow((STROKE/MAX_STROKE),3) * MAX_DIFF) + 10;
  customButton.setColor(color(255*reds.getValue(),255*greens.getValue(),255*blues.getValue()));
  customButton.show();
  pickedButton.show();
  
  tools.show();
}


void mousePressed()
{
  if (mouseX < width-PANEL) newUndo();
  clk = true;
  int k = 0;
  while(k++ < 3)
  {
    reds.mouseOver(true);
    greens.mouseOver(true);
    blues.mouseOver(true);
    strokes.mouseOver(true);
    redButton.mouseOver();
    greenButton.mouseOver();
    blueButton.mouseOver();
    yellowButton.mouseOver();
    cyanButton.mouseOver();
    magentaButton.mouseOver();
    whiteButton.mouseOver();
    greyButton.mouseOver();
    blackButton.mouseOver();
    customButton.mouseOver();
    pickedButton.mouseOver();
    tools.mouseOver();
  }
}

void mouseReleased()
{
  clk = false;
  reds.mouseOver(false);
  greens.mouseOver(false);
  blues.mouseOver(false);
  strokes.mouseOver(false);
}

void keyPressed()
{
  if (key == 'c')
  {
    clear = true;
  }
  
  if (key == 'r')
  {
    toReplace = get(mouseX,mouseY);
  }
 
  if (key == 'p')
  {
    pickedButton.setColor(get(mouseX,mouseY));
  }
  
  if (key == 'z')
  {
    undo();
  }
  
  if (key == 'x')
  {
    redo();
  }
}