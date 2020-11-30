//
// The problem with writing shaders is whenever I try and understand them later they make literally no senes to me whatsoever
// Seriously what the fuck is this
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 paletteuv; //UV coordinates of the palette on the texture sheet
uniform float voffset; //Which palette to select (0 is default)
uniform float pixelwidth;
uniform float pixelheight;
uniform float palettewidth; //How many colours are in the palette
uniform int outline;
uniform float brightness;

void main()
{
	vec4 currentcolour=texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 currentColourWithAlpha=v_vColour*currentcolour;			//The current colour preserving the alpha
																	//Sorry but I need this otherwise transparency isn't supported and I'm not refactoring this
	vec4 targetcolour=vec4(0.0,0.0,0.0,0.0);
	vec4 iseqvec;
	float iseq;
	for (float i=0.0; i<=palettewidth; i+=1.0)
		{
			//Get the colour we are comparing - this is the top row of the palette
			vec4 palettecolour=texture2D(gm_BaseTexture, vec2(paletteuv.x+pixelwidth*(i+0.5),paletteuv.y+0.5*pixelheight));
			//Now compare the colour with the colour of the pixel being drawn
			//Take the dot product of the target palette colour with thing which should be 1*target colour if a match is found or 0 otherwise
			//Actually don't take the dot product you fucking retard idiot because you can't dot a vector with a scalar
			iseqvec=(1.0-abs(sign(currentcolour-palettecolour))); //This is a vector containing all the values that are equal
			iseq=min(iseqvec.x,iseqvec.y);
			iseq=min(iseq,iseqvec.z);
			iseq=min(iseq,iseqvec.w);
			targetcolour+=texture2D(gm_BaseTexture, vec2(paletteuv.x+pixelwidth*(i+0.5),paletteuv.y+pixelheight*(voffset+0.5)))*iseq;
			//Sorry this is utterly HORRIFYING code
			if (iseq==1.0)
				{
					break;
				}
			if (i==palettewidth)
				{
					targetcolour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
				}
		}
		
	//Apply brightness
	float factor;
	//This gives us a number between 0 and sqrt(3)
	//We want this number to be between 0 and brightness, with the lower the number, the brighter the colour
	factor=sqrt(3.0)-sqrt(pow(targetcolour.r,2.0)+pow(targetcolour.g,2.0)+pow(targetcolour.b,2.0));
	factor=min(factor,brightness);
	//For the brightest colours, factor will be at a lowest, possibly below 1, so we make sure that the minimum factor is 1 (or brightness, if brightness is below 1)
	//So factor is at least 1.0 if brightness>1.0 or at least brightness if brightness<1.0
	factor=max(factor,min(1.0,brightness));
	//So I hope this now works
	targetcolour.rgb*=factor;
	targetcolour.r=min(targetcolour.r,1.0);
	targetcolour.g=min(targetcolour.g,1.0);
	targetcolour.b=min(targetcolour.b,1.0);
	
	//Omg an if ostatement
	if (outline==1)
		{
			vec2 offset;
			//Save pixel dimensions
			offset.x=pixelwidth;
			offset.y=pixelheight;
			//Save the current alpha (we only draw if we currently have an alpha of 0
			//Also save texture colour
			//Then save the coordinate
			vec3 Colour=targetcolour.rgb;
			float alpha=targetcolour.a;
			vec2 Coord=v_vTexcoord;
			//Now add enough colour to make it white multiplied by 1-alpha
			//Basically - alpha>0, adds nothing, alpha=0, makes the pixel white
			Colour+=vec3(1.0,1.0,1.0)*(1.0-sign(alpha));
			Colour.r=min(1.0,Colour.r);
			Colour.g=min(1.0,Colour.g);
			Colour.b=min(1.0,Colour.b);
			//Now we directly check the texture colours by I dunno, magic I guess
			alpha=max(alpha,texture2D(gm_BaseTexture,Coord+vec2(offset.x,0)).a);
			alpha=max(alpha,texture2D(gm_BaseTexture,Coord-vec2(offset.x,0)).a);
			alpha=max(alpha,texture2D(gm_BaseTexture,Coord+vec2(0,offset.y)).a);
			alpha=max(alpha,texture2D(gm_BaseTexture,Coord-vec2(0,offset.y)).a);
			//Okay so now we have an alpha=1 if next to ANY solid pixel
			//Add this all to the target colour and make sure it doesn't exceed 1.0 again
			targetcolour.rgb=Colour.rgb;
			targetcolour.r=min(1.0,targetcolour.r);
			targetcolour.g=min(1.0,targetcolour.g);
			targetcolour.b=min(1.0,targetcolour.b);
			currentcolour.a=max(currentcolour.a,alpha);
		}
	
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor=vec4(targetcolour.rgb,currentColourWithAlpha.a);
}
