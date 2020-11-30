//Created 11/12/19
//Last updated 11/12/19

//Sets up the palette swap shader with given params

//Get sprite and set uvs
//draw_self();
shader_set(shd_paletteswap);
var palettesprite=argument0;
var paletteuv=shader_get_uniform(shd_paletteswap,"paletteuv");
var uvs=sprite_get_uvs(palettesprite,0);
var _uvs; //We'll use this to hold the values we actually want
_uvs[0]=uvs[0];
_uvs[1]=uvs[1];
shader_set_uniform_f_array(paletteuv,_uvs);

//Set the palette number we want
var voffset=shader_get_uniform(shd_paletteswap,"voffset");
shader_set_uniform_f(voffset,argument1);

//Additional stuff
var pixelwidth=shader_get_uniform(shd_paletteswap,"pixelwidth");
var pixelheight=shader_get_uniform(shd_paletteswap,"pixelheight");
var palettewidth=shader_get_uniform(shd_paletteswap,"palettewidth");
var tex=sprite_get_texture(palettesprite,0);
var texwidth=texture_get_texel_width(tex);
var texheight=texture_get_texel_height(tex);
shader_set_uniform_f(pixelwidth,texwidth);
shader_set_uniform_f(pixelheight,texheight);
var width=sprite_get_width(palettesprite);
shader_set_uniform_f(palettewidth,width);

//Outline
var _outline=shader_get_uniform(shd_paletteswap,"outline");
var out;
var _parent=object_get_parent(object_index);
if (_parent==parent_possessable or _parent==parent_enemy)
	{
		out=outlineshader;
	}
else
	{
		out=false;
	}
shader_set_uniform_i(_outline,out);

//brightness
var _bright=shader_get_uniform(shd_paletteswap,"brightness");
if (argument2==false)
	{
		var _b=1;
	}
else
	{
		var _b=global.brightness;
	}
	
shader_set_uniform_f(_bright,_b);