int UNIT = 40;
int MAX = 4;
int AREA = 12;

MosaicC mos;

void setup()
{
  //noLoop();
  size(800,600);
  frameRate(5);
  mos = new MosaicC(UNIT,MAX);
  mos.generateMap();
}

void draw()
{
  background(0);
  mos.show();
  mos.generateMap();
}



// CLASSES



class Piece
{
  int X,Y,W,H;
  color col;

  Piece(int x, int y, int w, int h)
  {
    X = x;
    Y = y;
    W = w;
    H = h;
    col = color(random(255),random(255),random(255));
  }

  void show()
  {
    noStroke();
    fill(col);
    rect(X,Y,W,H);
  }
}

class MosaicC
{
  ArrayList<Piece> pieces;
  int DIM;
  int VAR;
  int R,C;

  MosaicC(int unit, int variance)
  {
    DIM = unit;
    VAR = variance;

    R = height/DIM;
    C = width/DIM;
    pieces = new ArrayList<Piece>();
  }

  void show()
  {
    for (Piece P : pieces)
      P.show();
  }

  void generateMap()
  {
    pieces.clear();
    boolean[] grid;

    grid = new boolean[R*C];
    for (int i=0; i<grid.length; ++i)
      grid[i] = false;

    int index = 0;
    boolean stat;
    do
    {
      int x = index%C;
      int y = index/C;
      int w = ceil(random(VAR));
      int h = ceil(random(VAR));

      if (x+w > C || y+h > R || w*h > AREA) continue;
      
      stat = false;
      for (int ix=0; ix<w; ++ix)
        for (int iy=0; iy<h; ++iy)
          if (grid[(x+ix)+(y+iy)*C] == true)
          {
              stat = true;
              break;
          }
      if (stat == true) continue;
      
      pieces.add(new Piece(x*DIM,y*DIM,w*DIM,h*DIM));

      for (int ix=0; ix<w; ++ix)
        for (int iy=0; iy<h; ++iy) 
          grid[(x+ix)+(y+iy)*C] = true;

      int place = 0;
      for (place=0; place<grid.length; ++place)
        if (grid[place] == false) break;
      index = place;
      if (index == grid.length) break;
    }
    while (true);
  }
}