/* CREARE UN'APPLICAZIONE CHE MUOVA UNA PALLINA SU UNO SCHERMO
 * CON POSIZIONE E VELOCITÀ RANDOM (E CON RIMBALZI SUI BORDI)
 * USANDO SOLO IL MOUSE.
 * È CONCESSA PIENA LIBERTÀ DI PROGRAMMAZIONE PURCHÈ IL RISULTATO
 * FINALE SIA LO STESSO DI QUELLO PROPOSTO DI SEGUITO O SIMILE.
 * PER NESSUN MOTIVO E' CONCESSO TOCCARE LA TASTIERA.
 * E' TUTTAVIA POSSIBILE USARE QUALSIASI STRUMENTO ESTERNO,
 * PURCHE' NON SIA DI IMMISSIONE DIRETTA (TIPO TASTIERA VIRTUALE).
 * REGISTRARE I TEMPI (E GLI STUMENTI UTILIZZATI) NELLA LISTA DI SEGUITO:
 
#1 - Michezio -> 54:02 [5.11.2017] (LibreOffice Write con la funzione inserisci simbolo, elenco di tutti i simboli, poi copia-incolla dei singoli caratteri)
#2 - 
#3 -
#4 -
#5 -

*/

class Ball  // Declare class Ball
{
  float x;
  float y;
  float vel_x;
  float vel_y;
  float size;
  
  Ball()  // construct the Ball object to have random position, speed and size
  {
    x = random(width);
    y = random(height);
    vel_x = random(-10,10);
    vel_y =  random(-10,10);
    size = random(10,100);
  }
  
  void show()  // display the ball as a black circle of a given diameter at the actual position
  {
    fill(0);
    ellipse(x,y,size,size);
  }
  
  void update()  // update the position with the given velocity and bounce back from borders
  {  
    x += vel_x;
    y += vel_y;
    if(x >= width-size/2){
      x = width-size/2;
      vel_x = -vel_x;
    }
    if(x <= size/2){
      x = size/2;
      vel_x = -vel_x;
    }
    if(y >= height-size/2){
      y = height-size/2;
      vel_y = -vel_y;
    }
    if(y <= size/2){
      y = size/2;
      vel_y = -vel_y;
    }
  }
}

Ball b = new Ball();

void setup()  // create a fix dimension canvas with white background
{
  size(640,480);
  background(255);
}

void draw()  // draw the object at 30/60 fps
{
  background(255);
  b.update();
  b.show();
}