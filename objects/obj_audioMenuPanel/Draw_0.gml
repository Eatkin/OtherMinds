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
//Sprites - sound/volume/3d sound enabled
var spr=(global.sound_fx_on)	?	spr_tick	:	spr_cross;
draw_sprite(spr,0,x+hoffset,y+32);
spr=(global.music_on)	?	spr_tick	:	spr_cross;
draw_sprite(spr,0,x+hoffset,y+48);
spr=(global.sound_3d)	?	spr_tick	:	spr_cross;
draw_sprite(spr,0,x+hoffset,y+64);

//Sound volume slider
var slider=spr_slider;
var bar=spr_slider_bar;
var posrange=sprite_get_width(slider)-sprite_get_width(bar);
var _pos;
_pos=global.sound_fx_volume*global.sound_fx_on*posrange;
draw_sprite(slider,0,x+hoffset,y+80);
draw_sprite(bar,0,x+hoffset+_pos,y+80);

//Repeat for music
_pos=global.music_volume*global.music_on*posrange;
draw_sprite(slider,0,x+hoffset,y+96)
draw_sprite(bar,0,x+hoffset+_pos,y+96);

//Alignment reset
draw_set_valign(fa_top);


var chevronOffset=4*(dsin(chevronTimer)-1);
draw_sprite(spr_menuChevron,0,chevronX+chevronOffset,chevronY-5);		//-5 accounts for sprite height