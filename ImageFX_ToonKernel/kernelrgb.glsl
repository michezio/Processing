#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

uniform float rKernel[9];
uniform float gKernel[9];
uniform float bKernel[9];

varying vec4 vertTexCoord;

void main() {
  vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
  vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
  vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
  vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
  vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
  vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
  vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
  vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

  vec4 col0 = texture2D(texture, tc0);
  col0 = vec4(col0.r * rKernel[0], col0.g * gKernel[0], col0.b * bKernel[0], 1.0);
  vec4 col1 = texture2D(texture, tc1);
  col1 = vec4(col1.r * rKernel[1], col1.g * gKernel[1], col1.b * bKernel[1], 1.0);
  vec4 col2 = texture2D(texture, tc2);
  col2 = vec4(col2.r * rKernel[2], col2.g * gKernel[2], col2.b * bKernel[2], 1.0);
  vec4 col3 = texture2D(texture, tc3);
  col3 = vec4(col3.r * rKernel[3], col3.g * gKernel[3], col3.b * bKernel[3], 1.0);
  vec4 col4 = texture2D(texture, tc4);
  col4 = vec4(col4.r * rKernel[4], col4.g * gKernel[4], col4.b * bKernel[4], 1.0);
  vec4 col5 = texture2D(texture, tc5);
  col5 = vec4(col5.r * rKernel[5], col5.g * gKernel[5], col5.b * bKernel[5], 1.0);
  vec4 col6 = texture2D(texture, tc6);
  col6 = vec4(col6.r * rKernel[6], col6.g * gKernel[6], col6.b * bKernel[6], 1.0);
  vec4 col7 = texture2D(texture, tc7);
  col7 = vec4(col7.r * rKernel[7], col7.g * gKernel[7], col7.b * bKernel[7], 1.0);
  vec4 col8 = texture2D(texture, tc8);
  col8 = vec4(col8.r * rKernel[8], col8.g * gKernel[8], col8.b * bKernel[8], 1.0);

  vec4 sum = col0 + col1 + col2 + col3 + col4 + col5 + col6 + col7 + col8;
  gl_FragColor = vec4(sum.rgb, 1.0);
}