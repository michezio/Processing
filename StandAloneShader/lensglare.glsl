#ifdef GL_ES
precision mediump float;
#endif

uniform float time;

varying vec4 vertTexCoord;

void main() {
    vec3 c;
    float l, z = time;
    for(int i=0; i < 3; i++) {
        vec2 uv, p = vertTexCoord.xy;
        uv = p;
        p -= 0.5;
        z += 0.07;
        l = length(p);
        uv += (abs(sin(z))) * abs(sin(l*10.0 - z*1.0));
        c[i] = 0.03 / length(uv - sin(time));
    }
    gl_FragColor = vec4(c/l, time);
}