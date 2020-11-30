//
// Simple passthrough fragment shader
//
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
	//Returns white if below a certain threshold V value in a really convoluted way
	gl_FragColor = vec4(1.0,1.0,1.0,alpha) * max(sign(0.15-fragHSV.z), 0.0) + v_vColour * textureColour * max(sign(fragHSV.z-0.15),0.0);
	//gl_FragColor=v_vColour*vec4(fragHSV.z,fragHSV.z,fragHSV.z,1);
}
