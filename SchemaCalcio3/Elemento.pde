final int BALL_SIZE = 30;
final int CONE_SIZE = 26;
final int PLAYER_SIZE = 40;
final int FOOTX = 10;
final int FOOTY = 22;
final int FOOT_SIZE_X = 14;
final int FOOT_SIZE_Y = 7;

final boolean FEET = true;

class Element
{
	PVector pos;
	color col;
	int size;

  Element()
  {}
  
  void show()
  {}
}

class Pupo extends Element
{
	Pupo (int x, int y, color team)
	{
		pos = new PVector(x,y);
		size = PLAYER_SIZE;
		col = team;
	}

	void show()
	{
		noStroke();
        fill(col);
        ellipse(pos.x,pos.y,size,size);
        if (FEET) 
        {
	        fill(0);
	        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
	        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
	    }
	}
}

class Ball extends Element
{
	Ball (int x, int y, color ball)
	{
		pos = new PVector(x,y);
		size = BALL_SIZE;
		col = ball;
	}

	void show()
	{
		noStroke();
        fill(col);
        ellipse(pos.x,pos.y,size,size);
	}

}

class Cone extends Element
{
	Cone (int x, int y, color shade)
	{
		pos = new PVector(x,y);
		size = CONE_SIZE;
		col = shade;
	}

	void show()
	{
		stroke(col);
        strokeWeight(size/3);
        noFill();
        ellipse(pos.x,pos.y,size/2,size/2);
	}
}