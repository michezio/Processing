#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 rMag, gMag, bMag;
uniform vec2 rOff, gOff, bOff;

varying vec4 vertTexCoord;

void main() {

    // texture is the whole canvas passed using filter() function
    // vertTexCoord is the coordinate (0 -> 1) that we are working on
    // texOffset is the size of 1 pixel in the range 0 -> 1
    // texture2D remaps texture using the function declared after

    /*
    	1.02 * vertTexCoord.st - 0.01
        means that the whole texture will be displayed in a space ranging from -0.01 to 1.01
        and since the texture is alwais in range 0 to 1 it will result as 2% smaller and
        offset by 1%
        Note that the above expression has been splitted into s and t component
        to allow more flexibility and asymmetry of the aberration
    */

    vec4 rValue = texture2D(texture, vec2(rMag.x * vertTexCoord.s + rOff.x, rMag.y * vertTexCoord.t + rOff.y));  
    vec4 gValue = texture2D(texture, vec2(gMag.x * vertTexCoord.s + gOff.x, gMag.y * vertTexCoord.t + gOff.y));
    vec4 bValue = texture2D(texture, vec2(bMag.x * vertTexCoord.s + bOff.x, bMag.y * vertTexCoord.t + bOff.y));  

    // Combine the offset colors.
    gl_FragColor = vec4(rValue.r, gValue.g, bValue.b, 1.0);
}