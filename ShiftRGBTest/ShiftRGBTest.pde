ShiftRGB aber;
float t;

void setup()
{
	size(600,600,P2D);
  noSmooth();
  //frameRate(1000);
  
	aber = new ShiftRGB(0);
  //aber.randomize(3);
}

void draw()
{
	background(0);
  
  drawPattern();

  aber.setRed(0, 0, 0.5*cos(t), 0.5*sin(t));
  aber.setGreen(0, 0.5*cos(t + TWO_PI/3), 0.5*sin(t + TWO_PI/3));
  aber.setBlue(0, 0.5*cos(t + 2*TWO_PI/3), 0.5*sin(t + 2*TWO_PI/3));
  aber.render();
  
  t += 0.1;
  //println(frameRate);
}

void drawPattern() {
  ellipseMode(CENTER);  
  rectMode(CENTER);
  stroke(255);
  strokeWeight(4);
  line(100, height/2, width - 100, height/2);
  line(width/2, 100, width/2, height - 100);
  strokeWeight(2);
  line(100, 100, width - 100, height - 100);
  line(100, height - 100, width - 100, 100);
  strokeWeight(1);
  line(100, 0, 100, height);
  line(width - 100, 0, width - 100, height);
  line(0, 100, width, 100);
  line(0, height - 100, width, height - 100);
  fill(255);
  noStroke();
  rect(width/2, height/2, 200, 200);
  rect(100, 100, 100, 100);
  rect(width - 100, 100, 100, 100);
  rect(width - 100, height - 100, 100, 100);
  rect(100, height - 100, 100, 100);
  ellipse(width/2, 100, 70, 70);
  ellipse(width - 100, height/2, 70, 70);
  ellipse(width/2, height - 100, 70, 70);
  ellipse(100, height/2, 70, 70);
  rect(100, height/2 + 90, 25, 25);
  rect(100, height/2 - 90, 25, 25);
  rect(width/2 + 90, 100, 25, 25);
  rect(width/2 - 90, 100, 25, 25);
  rect(width - 100, height/2 + 90, 25, 25);
  rect(width - 100, height/2 - 90, 25, 25);
  rect(width/2 + 90, height - 100, 25, 25);
  rect(width/2 - 90, height - 100, 25, 25);
  fill(0);
  rect(width/2, height/2, 50, 50);
  rect(100, 100, 25, 25);
  rect(width - 100, 100, 25, 25);
  rect(width - 100, height - 100, 25, 25);
  rect(100, height - 100, 25, 25);
}
