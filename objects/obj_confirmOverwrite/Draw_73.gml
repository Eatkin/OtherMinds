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
draw_set_valign(fa_bottom);
draw_text(x+48,y+vrepeats*16-4,option[0]);
draw_set_halign(fa_right)
draw_text(x+hrepeats*16-48,y+vrepeats*16-4,option[1]);

//Draw text after because we reset alignment here to avoid multiple calls
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(x+16,y,text);

var chevronOffset=4*(dsin(chevronTimer)-1);
draw_sprite(spr_menuChevron,0,chevronX+chevronOffset,chevronY);