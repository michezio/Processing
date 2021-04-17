#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 bias;
uniform vec2 scale;
uniform float kernel[9];

varying vec4 vertTexCoord;

void main() {

  vec2 offset = texOffset.st * scale.st;
  vec2 position = vertTexCoord.st + bias.st * texOffset.st;

  vec2 tc0 = position + vec2(-offset.s, -offset.t);
  vec2 tc1 = position + vec2(      0.0, -offset.t);
  vec2 tc2 = position + vec2(+offset.s, -offset.t);
  vec2 tc3 = position + vec2(-offset.s,       0.0);
  vec2 tc4 = position + vec2(      0.0,       0.0);
  vec2 tc5 = position + vec2(+offset.s,       0.0);
  vec2 tc6 = position + vec2(-offset.s, +offset.t);
  vec2 tc7 = position + vec2(      0.0, +offset.t);
  vec2 tc8 = position + vec2(+offset.s, +offset.t);

  vec4 col0 = texture2D(texture, tc0) * kernel[0];
  vec4 col1 = texture2D(texture, tc1) * kernel[1];
  vec4 col2 = texture2D(texture, tc2) * kernel[2];
  vec4 col3 = texture2D(texture, tc3) * kernel[3];
  vec4 col4 = texture2D(texture, tc4) * kernel[4];
  vec4 col5 = texture2D(texture, tc5) * kernel[5];
  vec4 col6 = texture2D(texture, tc6) * kernel[6];
  vec4 col7 = texture2D(texture, tc7) * kernel[7];
  vec4 col8 = texture2D(texture, tc8) * kernel[8];

  vec4 sum = col0 + col1 + col2 + col3 + col4 + col5 + col6 + col7 + col8;
  gl_FragColor = vec4(sum.rgb, 1.0);
}