//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float brightness;
uniform float greyscale;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float factor;
	//This gives us a number between 0 and sqrt(3)
	//We want this number to be between 0 and brightness, with the lower the number, the brighter the colour
	factor=sqrt(3.0)-sqrt(pow(gl_FragColor.r,2.0)+pow(gl_FragColor.g,2.0)+pow(gl_FragColor.b,2.0));
	factor=min(factor,brightness);
	//For the brightest colours, factor will be at a lowest, possibly below 1, so we make sure that the minimum factor is 1 (or brightness, if brightness is below 1)
	//So factor is at least 1.0 if brightness>1.0 or at least brightness if brightness<1.0
	factor=max(factor,min(1.0,brightness));
	//So I hope this now works
	gl_FragColor.rgb*=factor;
	gl_FragColor.r=min(gl_FragColor.r,1.0);
	gl_FragColor.g=min(gl_FragColor.g,1.0);
	gl_FragColor.b=min(gl_FragColor.b,1.0);
	
	//Now apply the greyscale
	vec3 lum = vec3(0.299, 0.587, 0.114);
	gl_FragColor=gl_FragColor*(1.0-greyscale)+greyscale*vec4(vec3(dot(gl_FragColor.rgb,lum)),gl_FragColor.a);
}
