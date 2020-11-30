//
// Simple passthrough fragment shader
//
uniform vec2 shad_huesatshift;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//RGB to HSV method
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
 
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

//HSV to RGB method
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main()
{
    vec4 textureColour=texture2D(gm_BaseTexture,v_vTexcoord);
	vec3 fragRGB = textureColour.rgb;
	vec3 fragHSV = rgb2hsv(fragRGB).xyz;
	float alpha=textureColour.a;
	//We get these because the shifts are over the interval [0,1] and these aren't
	float huecurrent=fragHSV.x;
	float satcurrent=fragHSV.y;
	//Okay now we set the hue shift and sat shift
	//We reduce the hue towards red and reduce the sat towards white
	//Uhh I don't know what I'm doing lol
	fragHSV.x=fragHSV.x-shad_huesatshift.x*huecurrent;
	fragHSV.y=fragHSV.y-shad_huesatshift.y*satcurrent;
	//Make sure these don't turn negative because that wouldn't make sense
	fragHSV.x=mod(fragHSV.x,1.0); //Hue wraps round to 1.0
	fragHSV.y=max(fragHSV.y,0.0);
	fragRGB = hsv2rgb(fragHSV);
	gl_FragColor = vec4(fragRGB, alpha);
}
