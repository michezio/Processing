#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform int levels;
uniform float noise;
uniform float seed;

varying vec4 vertTexCoord;

vec3 rand3(vec2 st) {
	float r = fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123*seed);
    float g = fract(sin(dot(st.xy,vec2(11.0237,83.167)))*43731.6899421*seed);
	float b = fract(sin(dot(st.xy,vec2(13.4413,80.941)))*43780.1235548*seed);
	return (vec3(r, g, b) * 2.0 - 1.0);
}

void main() {
  
  float L = float(levels);
  vec4 pix = texture2D(texture, vertTexCoord.st);
  vec3 n = noise * rand3(vertTexCoord.st);
  vec3 p = (pix.rgb + n) * L;
  float rVal = floor(p.r + 0.5) / L;
  float gVal = floor(p.g + 0.5) / L;
  float bVal = floor(p.b + 0.5) / L;

  gl_FragColor = vec4(rVal, gVal, bVal, 1.0);
}