// UNDO NOT WORKING CORRECTLY


final int DEFAULT_SIZE = 10;

float RED = 0;
float GREEN = 0;
float BLUE = 0;

boolean clk = true;
boolean active = false;
boolean showpanel = false;
boolean clear = false;
boolean undoState = false;

color baseColor;
PImage checkboard;

int gridSize = DEFAULT_SIZE;

color[][] imgUndo, imgRedo;

Panel panel;
Sprite sprite;

void setup()
{
  frameRate(1000);
  noSmooth();
  size(800,700);
  imgUndo = new color[width-PANEL][height];
  imgRedo = new color[width-PANEL][height];
  for (int i=0; i<width-PANEL; i++)
    for (int j=0; j<height; j++)
      imgRedo[i][j] = imgUndo[i][j] = color(255,255,255);
  panel = new Panel();
  sprite = new Sprite(gridSize);
  generateBackground();
}

void draw()
{
  if (clk)
  {
    if (mouseX > 0 && mouseX < width-panel.size && mouseY > 0 && mouseY < height)
      if (mouseButton == LEFT) sprite.setBlockColor(mouseX,mouseY,color(RED,GREEN,BLUE));
      else if (mouseButton == RIGHT) sprite.setBlockColor(mouseX,mouseY,color(255,0));
    clear();
    image(checkboard,0,0);
    sprite.show();
    panel.show();  
  }
}

void mousePressed()
{
  if (mouseX < width-panel.size) newUndo();
  if (panel.gridButton.mouseOver())
  {
    newUndo();
    sprite.setGrid(ceil(panel.grids.getValue()*127)+1);
  }
  clk = true;
  int k = 0;
  while(k++ < 3) panel.checkStart();
}

void mouseReleased()
{
  clk = false;
  panel.checkStop();
}

void keyPressed()
{
  if (key == 'g') sprite.showGrid = !sprite.showGrid;
  if (key == 'c') sprite.clear();
  if (key == 'p')
    if (mouseX > 0 && mouseX < width-panel.size && mouseY > 0 && mouseY < height)
      panel.pickedButton.setColor(sprite.getBlockColor(mouseX,mouseY));
  if (key == 'z') undo();
  if (key == 's') saveSprite(); 
  clk = true;
}

void keyReleased()
{
  clk = false;
}