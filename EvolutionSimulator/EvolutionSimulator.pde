final float H_SIZE = 15;
final float H_MET = 50;
final int H_GEN = 100;
final int H_NUM = 100;
final float H_PROL = 0.7;
final float H_STRV = 0.2;
final float H_HEL = 1000;

final float C_SIZE = 20;
final float C_MET = 100;
final int C_GEN = 150;
final int C_NUM = 30;
final float C_PROL = 0.7;
final float C_STRV = 0.2;
final float C_HEL = 1000;

final float F_SIZE = 5;
final int F_SPEED = 3;
final int F_NUM = 1000;

final int SPEED_MUT = 1;
final int SIGHT_MUT = 5;

int TIME;
int UPDATE_STEP = 1;
int INTIME;


ArrayList<Food> food;
ArrayList<Carnivore> carns;
ArrayList<Herbivore> herbs;

void setup()
{
  frameRate(1000);
  size(1200,900,P2D);
  colorMode(HSB);
  food = new ArrayList<Food>();
  for (int i=0; i<F_NUM; i++)
    food.add(new Food());
  carns = new ArrayList<Carnivore>();
  for (int i=0; i<C_NUM; i++)
    carns.add(new Carnivore(i));
  herbs = new ArrayList<Herbivore>();
  for (int i=0; i<H_NUM; i++)
    herbs.add(new Herbivore(i));
}

void draw()
{
  background(0);
  TIME = (++TIME) % UPDATE_STEP;
  
  if (TIME == 0)
  {
    INTIME = (++INTIME) % F_SPEED;
    if (INTIME == 0) food.add(new Food());
    
    for (Food F : food)        // UPDATE FOODS
      F.show();
    
    for (int n=carns.size()-1; n>=0; n--)    // UPDATE CARNS
    {
      Carnivore C = carns.get(n);
      C.update();
      C.show();
      if (C.generate)      // GENERATE NEW CARN
      {
        carns.add(new Carnivore(C));
        C.generate = false;
      }
      for (int i=herbs.size()-1; i>=0; i--)            // SEEK FOR HERBS
        if(C.seek(herbs.get(i)))
        {
          C.health += C_MET;
          herbs.remove(i);
        }
      if (C.health == 0) carns.remove(n);
    }
    
    for (int k=herbs.size()-1; k>=0; k--)      // UPDATE HERBS
    {
      Herbivore H = herbs.get(k);
      H.update();
      H.show();
      if (H.generate)     // GENERATE NEW HERB
      {
        herbs.add(new Herbivore(H));
        H.generate = false;
      }
      int danger = 0;
      for (Carnivore C : carns)      // FLEE FROM CARNS
        danger += H.flee(C);
      if (danger == 0)
      {
        for (int i=food.size()-1; i>=0; i--)      // IF NO CARN SEEK FOR FOOD
          if(H.seek(food.get(i)))
          {
            H.health += H_MET;
            food.remove(i);
          }
      }
      if (H.health == 0) herbs.remove(k);
    }
  }
  else
  {
    for (Food F : food)
      F.show(); 
    for (Herbivore H : herbs)
      H.show();
    for (Carnivore C : carns)
      C.show();
  }
}

void keyPressed()
{
  if (key == 'w')
    UPDATE_STEP--;
  if (key == 's')
    UPDATE_STEP++;
    
  if (UPDATE_STEP < 1) UPDATE_STEP = 1;
}