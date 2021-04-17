float BALL_SPEED = 80;
float BALL_DIMENSION = 35;
float PADDLE_SPEED = 12;
float PADDLE_WIDTH = 20;
float PADDLE_HEIGHT = 4;
float SPEED_INCREMENT = 0.5;
float ANGLE = PI/4;

Ball ball;
Paddle right;
Paddle left;
boolean[] keys;
int left_points = 0;
int right_points = 0;

void setup()
{
  //fullScreen();
  size(800,480);
  background(0);
  
  BALL_SPEED = width/BALL_SPEED;
  BALL_DIMENSION = height/BALL_DIMENSION;
  PADDLE_WIDTH = height/PADDLE_WIDTH;
  PADDLE_HEIGHT = height/PADDLE_HEIGHT;
  
  ball = new Ball(BALL_SPEED, BALL_DIMENSION, SPEED_INCREMENT);
  right = new Paddle(false, PADDLE_SPEED, PADDLE_WIDTH, PADDLE_HEIGHT);
  left = new Paddle(true, PADDLE_SPEED, PADDLE_WIDTH, PADDLE_HEIGHT);
  keys = new boolean[4];
}

void draw()
{
  background(0);
  if (left_points > 9 || right_points > 9)
  left_points = right_points = 0;
  
  ball.show();
  right.show();
  left.show();
  
  fill(255);
  textSize(32);
  text(left_points, width/2-40,40);
  text(right_points, width/2+20,40);
  fill(85);
  textSize(12);
  text("a/z for left, k/m for right", width/2-65, height - 20);
}

void keyPressed()
{
  if (key == 'a')
    keys[0] = true;
  if (key == 'z')
    keys[1] = true;
  if (key == 'k')
    keys[2] = true;
  if (key == 'm')
    keys[3] = true;
}

void keyReleased()
{
  if (key == 'a')
    keys[0] = false;
  if (key == 'z')
    keys[1] = false;
  if (key == 'k')
    keys[2] = false;
  if (key == 'm')
    keys[3] = false;
}

void mousePressed()
{
  ball.reset();
  left_points = 0;
  right_points = 0;
}