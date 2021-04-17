float sqDist(PVector p, PVector q) {
	float xx = p.x - q.x;
	float yy = p.y - q.y;
	return ( xx * xx + yy * yy );
}

float sqSize(float a) {
	return (a*a)/4.0;
}
