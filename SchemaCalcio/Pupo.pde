class Pupo
{
  PVector pos;
  int size;
  String type;
  

  Pupo (PVector _pos, String _type)
  {
    pos = _pos;
    type = _type;
    switch (type)
    {
      case "cone orange": size = CONE_SIZE; break;
      case "ball": size = BALL_SIZE; break;
      case "team a": case "team s":
      case "team z": case "team x":
      case "goalkeeper": size = PLAYER_SIZE; break;
    }
  }

  void show()
  {
    switch (type)
    {
      case "cone orange":
      {
        stroke(CONE_COLOR);
        strokeWeight(size/2.0);
        noFill();
        ellipse(pos.x,pos.y,size,size);
      } break;
      case "ball":
      {
        noStroke();
        fill(BALL_COLOR);
        ellipse(pos.x,pos.y,size,size);
      } break;
      case "team a":
      {
        noStroke();
        fill(TEAM_A_COLOR);
        ellipse(pos.x,pos.y,size,size);
        fill(0);
        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
      } break;
      case "team s":
      {
        noStroke();
        fill(TEAM_S_COLOR);
        ellipse(pos.x,pos.y,size,size);
        fill(0);
        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
      } break;
      case "team z":
      {
        noStroke();
        fill(TEAM_Z_COLOR);
        ellipse(pos.x,pos.y,size,size);
        fill(0);
        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
      } break;
      case "team x":
      {
        noStroke();
        fill(TEAM_X_COLOR);
        ellipse(pos.x,pos.y,size,size);
        fill(0);
        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
      } break;
      case "goalkeeper":
      {
        noStroke();
        fill(GK_COLOR);
        ellipse(pos.x,pos.y,size,size);
        fill(0);
        ellipse(pos.x-FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
        ellipse(pos.x+FOOTX,pos.y+FOOTY,FOOT_SIZE_X,FOOT_SIZE_Y);
      } break;
    }
  }
}  