final int PLAYER_SIZE = 50;
final int BALL_SIZE = 30;
final int CONE_SIZE = 10;

final color TEAM_A_COLOR = color(255,0,0);
final color TEAM_S_COLOR = color(255,255,0);
final color TEAM_Z_COLOR = color(40,40,255);
final color TEAM_X_COLOR = color(0,255,150);
final color GK_COLOR = color(40,40,40);
final color BALL_COLOR = color(230,230,230);
final color CONE_COLOR = color(255,80,30);

final float FOOTX = 18;
final float FOOTY = 28;
final float FOOT_SIZE_X = 20;
final float FOOT_SIZE_Y = 10;

final boolean foots = true;

PImage campo;

ArrayList<Pupo> pupi;

void setup()
{
	size(967,915);
	background(0);
  pupi = new ArrayList<Pupo>();
  campo = loadImage("campo.jpg");
  drawExtra();
}

void draw()
{
	image(campo,0,0,width,height);
	for (int i=0; i<pupi.size(); ++i)
		pupi.get(i).show();
}

void drawExtra()
{
  pupi.add(new Pupo(new PVector(433,774), "cone orange"));
  pupi.add(new Pupo(new PVector(531,774), "cone orange"));
}

void keyPressed()
{
	if (key == 'a') pupi.add(new Pupo(new PVector(mouseX,mouseY), "team a"));
	if (key == 's') pupi.add(new Pupo(new PVector(mouseX,mouseY), "team s"));
  if (key == 'z') pupi.add(new Pupo(new PVector(mouseX,mouseY), "team z"));
  if (key == 'x') pupi.add(new Pupo(new PVector(mouseX,mouseY), "team x"));
  if (key == 'd') pupi.add(new Pupo(new PVector(mouseX,mouseY), "goalkeeper"));
  if (key == 'w') pupi.add(new Pupo(new PVector(mouseX,mouseY), "ball"));
  if (key == 'q') pupi.add(new Pupo(new PVector(mouseX,mouseY), "cone orange"));
  
	if (key == 'c') 
  {
    boolean deleted = false;
    for (int i=0; i<pupi.size(); ++i)
    {
      Pupo v = pupi.get(i);
      if (dist(mouseX,mouseY,v.pos.x,v.pos.y) < v.size/2.0)
      {
        pupi.remove(i);
        deleted = true;
      }
      if (deleted) return;
    }
  }
  if (key == ' ') saveFrame("schema-####.png");
}

void mouseClicked()
{
  println(mouseX+"  "+mouseY);
}