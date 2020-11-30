//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float amp;
uniform float freq;
uniform float timer;

void main()
{
	vec2 Coord=v_vTexcoord;
	float dx=amp*cos(Coord.y*freq+(6.28*timer)/60.0);
	Coord.x=Coord.x+dx;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, Coord );
}
