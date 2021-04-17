#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  int si = int(vertTexCoord.s * 100.0);
  int sj = int(vertTexCoord.t * 60.0);
  gl_FragColor = texture2D(texture, vec2(float(si)/100.0, float(sj)/60.0)) * vertColor;
}