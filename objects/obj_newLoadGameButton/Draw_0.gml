/// @description draw the button from 9 slice

var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

for (var i=0; i<hrepeats; i+=1)
	for (var j=0; j<vrepeats; j+=1)	{
		//Bitmasks to select appropriate tile
		var tilenum=0;
		if (i>0)
			tilenum|=8;
		if (i<hrepeats-1)
			tilenum|=2;
		if (j>0)	
			tilenum|=1;
		if (j<vrepeats-1)
			tilenum|=4;
		
		//Now draw
		draw_sprite_part(sprite_index,image_index,tilenum*16,0,16,16,x+i*16,y+j*16);
	}
	
shader_reset();

//Now draw the text on top of the button, like this:
/*
| icon            date |
|                      |
| GAME1/NODATA    %%%  |
*/

draw_set_colour(c_white);

var padding=6;
//Set box boundaries and add additional paddings to the horizontal boxes
var x1=x+padding;
var x2=x+16*hrepeats-padding;
var y1=y;
var y2=y+16*vrepeats;


//Icon
if (icon!=noone)
	draw_sprite(icon,0,x1+padding+4,y1+padding+4);		//+4 to account for the icon's centre
	
//Game name
var txt="This is a bug";
if (gameExists)
	txt=text+" "+string(gameNum);
else
	txt=scr_return_text(71);		//No data

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(x1+padding,y2-padding,txt);

//Percentage complete
draw_set_halign(fa_right);
draw_text(x2-padding,y2-padding,percentage);

//Date
draw_set_valign(fa_top);
draw_text(x2-padding,y1+padding,date);

draw_set_halign(fa_left);