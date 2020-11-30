//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelwidth;
uniform float pixelheight;
uniform float pixelationscale;
uniform float u;
uniform float v;

void main()
{
	vec2 coord=v_vTexcoord-vec2(u,v); //Index coordinates from (0,0)
	vec2 coordoffset;
	coordoffset=mod(coord,pixelationscale*vec2(pixelwidth,pixelheight));
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord-coordoffset );
}
