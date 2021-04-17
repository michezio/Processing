int ROWS = 10;
int COLS = 15;
float RATIO = 0.3;

class Ibool
{
  int index;
  boolean full;
}

class Field
{
  float OGG_W = width/COLS;
  float OGG_H = height/ROWS;
  Ibool[][] map;
  ArrayList<Obstacle> objects;
  
  Field()
  {
    int k = 0;
    map = new Ibool[COLS][ROWS];
    objects = new ArrayList<Obstacle>();
    for (int i=0; i<COLS; i++)
    {
      for (int j=0; j<ROWS; j++)
      {
        map[i][j] = new Ibool();
        if (random(1) < RATIO) 
          map[i][j].full = true;
        else map[i][j].full = false;
        float x = i*OGG_W + OGG_W/2;
        float y = j*OGG_H + OGG_H/2;
        if(map[i][j].full) 
        {
          objects.add(new Obstacle(new PVector(x,y), OGG_W, OGG_H));
          map[i][j].index = k++;
        }
      }
    }
    
    for (int i=0; i<COLS; i++)
    {
      for (int j=0; j<ROWS; j++)
      {
        if (map[i][j].full)
        {
          int n = map[i][j].index;
          if (i == 0) objects.get(n).hasTop = false;
          if (j == 0) objects.get(n).hasLeft = false;
          if (i == ROWS-1) objects.get(n).hasBottom = false;
          if (i == COLS-1) objects.get(n).hasRight = false;
          
          int l = j-1; 
          int r = j+1; if(r>ROWS-1) r=ROWS-1;
          int u = i-1; if(u<0) u=0;
          int d = i+1; if(d>COLS-1) r=COLS-1;
          
          if(l>=0 && map[i][l].full) objects.get(n).hasLeft = false;
          if(r<=ROWS-1 && map[i][r].full) objects.get(n).hasRight = false;
          if(u>=0 && map[u][j].full) objects.get(n).hasTop = false;
          if(d<=COLS-1 && map[d][j].full) objects.get(n).hasBottom = false;
        }
      }
    }
  }
  
  void show()
  {
    for (int i=0; i<objects.size(); i++)
      objects.get(i).show();
  }
  
}