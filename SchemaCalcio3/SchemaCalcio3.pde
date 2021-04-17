final color TEAM_1 = color(255,0,0);
final color TEAM_2 = color(255,255,0);
final color TEAM_3 = color(40,40,255);
final color TEAM_4 = color(0,255,255);
final color GK = color(40,40,40);
final color BALL = color(230,230,230);
final color CONE_1 = color(255,80,30);
final color CONE_2 = color(200,30,255);
final color ARROW_1 = color(20,20,20);
final color ARROW_2 = color(255,0,128);
final color ARROW_3 = color(20,100,255);
final color ARROW_4 = color(0,255,128);
final color ARROW_5 = color(255,128,0);

PImage campo;

ArrayList<Element> pupi;
ArrayList<Arrow> arrows;
ArrayList<PVector> points;

void setup()
{
	size(1000,950);
	background(0);
  pupi = new ArrayList<Element>();
  arrows = new ArrayList<Arrow>();
  points = new ArrayList<PVector>();
  campo = loadImage("campo.jpg");
  preBuild();
}

void draw()
{
	image(campo,0,0,width,height);
	for (int i=0; i<pupi.size(); ++i)
		pupi.get(i).show();
  for (int i=0; i<arrows.size(); ++i)
    arrows.get(i).show();
  arrowBuilder(points);
}

void preBuild()
{
  pupi.add(new Cone(448, 804, CONE_1));
  pupi.add(new Cone(549, 804, CONE_1));
  
  //for (int i=0; i<7; ++i)
  //  pupi.add(new Cone(25+158*i, 435, CONE_1));
}

void mouseClicked()
{
  println(mouseX+"  "+mouseY);
}