// GAME

int LIFESPAN = 5;              // time (seconds) for new enemy to spawn
int FORECAST = 2;              // prevision time (seconds) before spawn
float HS_DIM = 15;             // highscore dimension (lower is bigger)
float S_DIM = 20;              // actual score dimension (lower is bigger)
float SPAWN_AREA = 0.01;       // initial size of prevision area (keep around 0.01)
int FPS = 60;

// ACTOR

float ACCMAX = 0.5;            // max acceleration
float DAMP = 0.985;            // speed dampening (per frame)
int ASIZE = 20;                // ball size (lower is bigger)
float BDAMP = 0.5;             // speed dampening from wall bounce
int ASHIFT = 85;               // hue shift from background

// ENEMIES

float ACCELERATION = 0.3;      // constant acceleration
float SPEED_DAMP = 0.97;       // speed dampening (per frame)
int REACTION = 60;             // force of rebounce (lower is bigger)
int ESIZE = 30;                // ball size (lower is bigger)
int ESHIFT = 170;              // hue shift from background

// ENVIRONMENT AND PARTICLES
float PSIZE = 0.3;              // particle size (% of enemy size)
int PRESENCE = 200;             // particle opacity
int CDENSE = 20;                // number of particles per collision
float PSPEED = 1;             // particle speed (% of bounce reaction)
float CWAVE = 3;              // collision wave size (% of display size)

// DEBUG

boolean SHOW_INFO = true;
boolean SHOW_TOUCH = true;
int INFO_SIZE = 20;
PVector INFO_POSITION = new PVector(20, 100);
color INFO_COLOR = color(255,255,255);




// SET PARAMETERS DEPENDENCIES FROM SCREEN SIZE
 
void setScreenDependency()
{
  REF = min(height,width);
  CWAVE = REF*CWAVE;
  ESIZE = REF/ESIZE;    
  PSIZE = ESIZE*PSIZE;
  ASIZE = REF/ASIZE;
  REACTION = REF/REACTION;
  PSPEED = REACTION*PSPEED;
  HS_DIM = REF/HS_DIM;
  S_DIM = REF/S_DIM;
  SPAWN_AREA = REF*SPAWN_AREA;
  timespan = FPS*LIFESPAN;
  foresee = FPS*(LIFESPAN-FORECAST);
}

// GENERATE A NEW COLOR PALETTE

void newPalette()
{
  BKG = floor(random(256));
  ACT = (BKG+ASHIFT)%255;
  ENM = (BKG+ESHIFT)%255;
}

void showInfo()
{
  textSize(INFO_SIZE);
  fill(INFO_COLOR);
  text(frameRate, INFO_POSITION.x, INFO_POSITION.y);
  text(enemies.size(), INFO_POSITION.x, INFO_POSITION.y + INFO_SIZE);
}