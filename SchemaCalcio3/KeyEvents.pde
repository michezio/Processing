void keyPressed()
{
  if (key == '1') pupi.add(new Pupo(mouseX, mouseY, TEAM_1));
  if (key == '2') pupi.add(new Pupo(mouseX, mouseY, TEAM_2));
  if (key == '3') pupi.add(new Pupo(mouseX, mouseY, TEAM_3));
  if (key == '4') pupi.add(new Pupo(mouseX, mouseY, TEAM_4));
  if (key == '5') pupi.add(new Pupo(mouseX, mouseY, GK));
  if (key == '0') pupi.add(new Ball(mouseX, mouseY, BALL));
  if (key == 'q') pupi.add(new Cone(mouseX, mouseY, CONE_1));
  if (key == 'w') pupi.add(new Cone(mouseX, mouseY, CONE_2));

  if (key == 'a' || key == 's' || key == 'd' || key == 'f' || key == 'g')
  {

    if ( points.size() < 3 ) points.add( new PVector(mouseX, mouseY) );
  
    if ( points.size() == 3 )
    {
      color c = color(0);
      switch (key)
      {
        case 'a': c = ARROW_1; break;
        case 's': c = ARROW_2; break;
        case 'd': c = ARROW_3; break;
        case 'f': c = ARROW_4; break;
        case 'g': c = ARROW_5; break;
      }
      arrows.add ( new Arrow(points,c) );
      points.clear();
    }
  }
  
  if (key == 'c' && points.size() == 0) 
  {
    boolean deleted = false;
    for (int i=arrows.size()-1; i>=0; --i)
    {
      Arrow v = arrows.get(i);
      if (dist(mouseX,mouseY,v.stop.x,v.stop.y) < v.wid)
      {
        arrows.remove(i);
        deleted = true;
      }
      if (deleted) return;
    }
    for (int i=pupi.size()-1; i>=0; --i)
    {
      Element v = pupi.get(i);
      if (dist(mouseX,mouseY,v.pos.x,v.pos.y) < v.size/2.0)
      {
        pupi.remove(i);
        deleted = true;
      }
      if (deleted) return;
    }
  }
  else if ( key == 'c' )
  {
    points.clear();
  }


  if (key == ' ')
  {
    saveFrame("schema-####.png");
    println("SAVED");
  }
}