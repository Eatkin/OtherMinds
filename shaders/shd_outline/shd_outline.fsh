//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelwidth;
uniform float pixelheight;
uniform float whitesprite;		//Why did I choose a float for a boolean? Because I'm an idiot that's why!

void main()
{
	vec2 offset;
	//Save pixel dimensions
	offset.x=pixelwidth;
	offset.y=pixelheight;
	//Save the current alpha (we only draw if we currently have an alpha of 0
	//Also save texture colour
	//Then save the coordinate
	vec4 textureColour=texture2D(gm_BaseTexture,v_vTexcoord);
	vec3 Colour=textureColour.rgb;
	float alpha=textureColour.a;
	vec2 Coord=v_vTexcoord;
	//Now add enough colour to make it white multiplied by 1-alpha - so this only applies to alpha<1
	Colour+=vec3(1.0,1.0,1.0)*(1.0-alpha);
	Colour.r=min(1.0,Colour.r);
	Colour.g=min(1.0,Colour.g);
	Colour.b=min(1.0,Colour.b);
	//Now we directly check the texture colours by I dunno, magic I guess
	alpha=max(alpha,texture2D(gm_BaseTexture,Coord+vec2(offset.x,0)).a);
	alpha=max(alpha,texture2D(gm_BaseTexture,Coord-vec2(offset.x,0)).a);
	alpha=max(alpha,texture2D(gm_BaseTexture,Coord+vec2(0,offset.y)).a);
	alpha=max(alpha,texture2D(gm_BaseTexture,Coord-vec2(0,offset.y)).a);

	//now set all colour to white if whitesprite is on
	//Sets all colour channels to 1.0 if whitesprite is on or makes no change otherwise
	Colour.r=max(whitesprite,Colour.r);
	Colour.g=max(whitesprite,Colour.g);
	Colour.b=max(whitesprite,Colour.b);

    gl_FragColor = vec4(Colour,alpha) * v_vColour;
}
