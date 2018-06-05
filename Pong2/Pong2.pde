float BALL_SPEED = 80;
float BALL_DIMENSION = 35;
float PADDLE_SPEED = 12;
float PADDLE_WIDTH = 20;
float PADDLE_HEIGHT = 4;
float SPEED_INCREMENT = 0.5;
float ANGLE = PI/4;
float FORCE = 0.01;
float PUSH = 3;

Ball ball;
Paddle right;
Paddle left;
boolean[] keysL;
boolean[] keysR;
int left_points = 0;
int right_points = 0;

void setup()
{
  //fullScreen();
  size(900,480);
  background(0);
  
  BALL_SPEED = width/BALL_SPEED;
  BALL_DIMENSION = height/BALL_DIMENSION;
  PADDLE_WIDTH = height/PADDLE_WIDTH;
  PADDLE_HEIGHT = height/PADDLE_HEIGHT;
  
  ball = new Ball(BALL_SPEED, BALL_DIMENSION, SPEED_INCREMENT);
  right = new Paddle(false, PADDLE_SPEED, PADDLE_WIDTH, PADDLE_HEIGHT);
  left = new Paddle(true, PADDLE_SPEED, PADDLE_WIDTH, PADDLE_HEIGHT);
  keysL = new boolean[4];
  keysR = new boolean[4];
}

void draw()
{
  background(0);
  if (left_points > 9 || right_points > 9)
  left_points = right_points = 0;
  
  stroke(127);
  line(width/2, 0, width/2, height);
  
  ball.show();
  right.show();
  left.show();
  
  fill(255);
  textSize(32);
  text(left_points, width/2-40,40);
  text(right_points, width/2+20,40);
  fill(85);
  textSize(12);
  text("wasd for left    ijkl for right", width/2-80, height - 20);
}

void keyPressed()
{
  if (key == 'w')
    keysL[0] = true;
  if (key == 's')
    keysL[1] = true;
  if (key == 'a')
    keysL[2] = true;
  if (key == 'd')
    keysL[3] = true;
  if (key == 'i')
    keysR[0] = true;
  if (key == 'k')
    keysR[1] = true;
  if (key == 'j')
    keysR[2] = true;
  if (key == 'l')
    keysR[3] = true;
}

void keyReleased()
{
   if (key == 'w')
    keysL[0] = false;
  if (key == 's')
    keysL[1] = false;
  if (key == 'a')
    keysL[2] = false;
  if (key == 'd')
    keysL[3] = false;
  if (key == 'i')
    keysR[0] = false;
  if (key == 'k')
    keysR[1] = false;
  if (key == 'j')
    keysR[2] = false;
  if (key == 'l')
    keysR[3] = false;
}

void mousePressed()
{
  ball.reset();
  left_points = 0;
  right_points = 0;
  left.y = right.y = height/2;
  left.x = left.d + left.w/2;
  right.x = width - right.d - right.w/2;
}