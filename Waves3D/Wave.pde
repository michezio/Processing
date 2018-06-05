class Wave
{
  float[] pt;
  int points;
  boolean full;

  Wave(int size, boolean f)
  {
  	pt = new float[size];
  	points = size;
  	full = f;
  }

  void plot(float num, float nx, float ny)
  {
  	for (int i=0; i<points; ++i)
      pt[i] = noise(i*nx,ny+num);
  }

  void display(PVector pos, color col, float... par)
  {
  	float amp = par.length < 1 ? 1 : par[0];
  	float size = par.length < 2 ? width : par[1];
  	float tall = par.length < 3 ? height : par[2];

  	stroke(col);
  	float space = size/(points-1);
    beginShape();
    curveVertex(pos.x, pt[0]*amp + pos.y);
    for (int i=0; i<points; ++i) 
      curveVertex(pos.x + i*space, pt[i]*amp + pos.y);
    curveVertex(pos.x + size, pt[points-1]*amp + pos.y);
    if (full)
    {
      vertex(pos.x + size, pt[points-1]*amp + pos.y);
      vertex(pos.x + size, tall);
      vertex(pos.x, tall);
      vertex(pos.x, pt[0]*amp + pos.y);
      endShape(CLOSE);
    }
    else endShape();
  }
}