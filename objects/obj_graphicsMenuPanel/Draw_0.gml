/// @description draw 9-slice + text
//Draw end so ALWAYS on top

var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

//Drwa from 9slice
for (var i=0; i<hrepeats; i+=1)
	for (var j=0; j<vrepeats; j+=1)	{
		//Bitmasking bollocks
		var tileOffset=0;
		if (i>0)
			tileOffset|=8;
		if (i<hrepeats-1)
			tileOffset|=2;
		if (j>0)
			tileOffset|=1;
		if (j<vrepeats-1)
			tileOffset|=4;
			
		draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,x+i*16,y+j*16);
	}
	
shader_reset();

//Now we draw our options
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Header
draw_text(x+hrepeats*8,y+16,headerText);

draw_set_halign(fa_left);
//Options - need some column alignment
/*Eg
help bar enabled		x
Difficulty				< Easy >
Vibration enabled		x
*/
//Draw all options and find LH columntext alignment
var len=array_length_1d(option);
var maxLength=0;
for (var i=0; i<len; i+=1)	{
	draw_text(x+32,y+32+16*i,option[i]);
	maxLength=max(maxLength,string_width(option[i]));
}

var hoffset=ceil(2+maxLength/16)*16;
//Sprites - full screen and vsync
var spr=(window_get_fullscreen())	?	spr_tick	:	spr_cross;
draw_sprite(spr,0,x+hoffset,y+48);
spr=(global.vsync)	?	spr_tick	:	spr_cross;
draw_sprite(spr,0,x+hoffset,y+64);

//Scale text
var scaleText="";
if (global.windowscale>1)
	scaleText+="< ";
scaleText+=string(global.windowscale);
if (global.windowscale<maxScale)
	scaleText+=" >";
draw_text(x+hoffset,y+32,scaleText);

//Gamepad icons
var padText="";
if (global.gamepadtype>0)
	padText+="< ";
//Ternery operators because I don't want to understand this in future
padText+=(global.gamepadtype==PAD.XBOX)	?	scr_return_text(51)	:	((global.gamepadtype==PAD.PS)	?	scr_return_text(52)	:	scr_return_text(53));
if (global.gamepadtype<PAD.NINTENDO)
	padText+=" >";

draw_text(x+hoffset,y+80,padText);
	
//Font
var fontText="";
fontText+=(global.font==1)	?	"< "+scr_return_text(50) : scr_return_text(49)+" >";

draw_text(x+hoffset,y+96,fontText);

//Transitions
var transText="";
transText+=(global.transitions==0)	?	scr_return_text(46)+" >"	:	((global.transitions==1)	?	"< "+scr_return_text(47)+" >"	:	"< "+scr_return_text(48));

draw_text(x+hoffset,y+112,transText);

//Brightness is a slider
var slider=spr_slider;
var bar=spr_slider_bar;
var posrange=sprite_get_width(slider)-sprite_get_width(bar);
var _pos;
var multiplier=(5-logn(0.95,global.brightness))*0.1; //This gives us a number in the range 0-1
	_pos=multiplier*posrange;
draw_sprite(slider,0,x+hoffset,y+128);
draw_sprite(bar,0,x+hoffset+_pos,y+128);

//Alignment reset
draw_set_valign(fa_top);

var chevronOffset=4*(dsin(chevronTimer)-1);
draw_sprite(spr_menuChevron,0,chevronX+chevronOffset,chevronY-5);		//-5 accounts for sprite height