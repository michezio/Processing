// Create a heatmap to show which places are the most visited.

final boolean REAL_TIME = false;

final int PLACES = 40;
final int LAUNCHES = 10000000;
float DIM;

Case[] grid = new Case[40];
int repetition = 0;
int actual = 0;

void setup()
{
	if (REAL_TIME) frameRate(1);
  else noLoop();
	size(640,640);
	background(200,255,200);

	DIM = width/11.0;

	for (int i=0; i<PLACES; ++i)
		grid[i] = new Case(i);
  
  if (!REAL_TIME)
  {
  	for (int i=0; i<LAUNCHES; ++i)
  		play();
  }
}

void draw()
{
  int max = grid[0].count;
  int min = grid[0].count-1;
  for (int i=1; i<PLACES; ++i)
  {
    if (grid[i].count > max) max = grid[i].count;
    if (grid[i].count < min) min = grid[i].count;
  }
  
  if (REAL_TIME) play();
  
	for (int i=0; i<PLACES; ++i)
	{
		float x = 0;
		float y = 0;
		if (grid[i].number < 10)
		{
			x = width-DIM-grid[i].number*DIM;
			y = height-DIM;
		}
		else if (grid[i].number < 20)
		{
			x = 0;
			y = height-DIM-(grid[i].number-10)*DIM;
		}
		else if (grid[i].number < 30)
		{
			x = (grid[i].number-20)*DIM;
			y = 0;
		}
		else if (grid[i].number < 40)
		{
			x = width-DIM;
			y = (grid[i].number-30)*DIM;
		}
		grid[i].show(x,y,min,max);
	}
}

void play()
{
  actual = diceRoll(actual);
  grid[actual].count++;
  if (actual == 2 || actual == 17 || actual == 33) actual = probability(actual);
  else if (actual == 7 || actual == 22 || actual == 36) actual = unforeseen(actual);
  else if (actual == 30) actual = 10;
}

int diceRoll(int actual)
{
	int d1 ;
	int d2;

	//if (actual == 10)
	//{
	//	int k = 1;
	//	do
	//	{
	//		d1 = ceil(random(6));
	//		d2 = ceil(random(6));
	//		++k;
	//	}
 //   while (k < 3 || d1 != d2);
	//}
	//else 
	{
		d1 = ceil(random(6));
		d2 = ceil(random(6));

		if (d1 == d2)
			++repetition;
		else repetition = 0;

		if (repetition == 3)
		{
			repetition = 0;
			return 10;
		}
	}

	return (actual+d1+d2)%PLACES;
}

int probability(int actual)
{
	int x = actual;
	int c = ceil(random(16));
	if (c == 1) x = 0;			// via
	else if (c == 2) x = 10;	// prigione

	if (x != actual) grid[x].count++;

	return x;
}


int unforeseen(int actual)
{
	int x = actual;
	int c = ceil(random(16));
	if (c == 0 || c == 1) // prossima stazione
	{
		if (actual == 7) x = 15;
		else if (actual == 22) x = 25;
		else if (actual == 36) x = 5;
	}
	else if (c == 2)	// prossima società  
	{
		if (actual == 7) x = 12;
		else if (actual == 22) x = 28;
	}
	else if (c == 3) x = 24;	// largo colombo
	else if (c == 4) x = 10;	// prigione
	else if (c == 5) x = 39;	// parco della vittoria
	else if (c == 6) x = 0;		// via
	else if (c == 7) x = actual-3;
	else if (c == 8) x = 25;	// stazione nord
	else if (c == 9) x = 13;	// corso ateneo

	if (x != actual) grid[x].count++;

	return x;
}