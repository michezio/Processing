#ifdef GL_ES
precision mediump float;
#endif

uniform float time;

varying vec4 vertTexCoord;

void main() {
	vec2 v = vertTexCoord.xy - 0.5;
    float q = sqrt(v.x * v.x + v.y * v.y);
    float k = cos((5*exp(q+2))*q)/(1+q);
    float r = 0.7 * k;
    float g = 1 * k;
    float b = 2 * k;
    gl_FragColor = vec4(r*r, g, b, time);
}