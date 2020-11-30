//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;

//take the fractional part of the sin of an arbitrarily large number
float random (vec2 pos)	{
	return fract(sin(dot(pos.xy,12345.6789*vec2(12.345,67.891))));
}

void main()
{
	float rng=random(v_vTexcoord*time);
	gl_FragColor=vec4(vec3(rng),1.0);
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
