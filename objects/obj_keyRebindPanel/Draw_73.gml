/// @description

//Draw a black rectangle behind cause it's distracting having clutter in the background
var alph=0.5*(1-releaseKeysTimer/60);
draw_set_alpha(alph);
draw_set_colour(c_black);
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);

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

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);

//Header
var hText=headerText+": "+keyString;
draw_text(x+hrepeats*8,y+16,hText);

//Other text
var sep=string_height("A");
var w=(hrepeats-2)*16
draw_text_ext(x+hrepeats*8,y+vrepeats*8,output,sep,w);