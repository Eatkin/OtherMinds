/// @description Insert description here
// You can write your code in this editor

if (global.hardpause or !showingnotification)
	exit;

//Draw slightly transparent - good thing I modified the palette swap shader to account for semi-transparent sprites
draw_set_alpha(0.8);
	
//9 slice!
var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

//Drwa from 9slice
for (var i=0; i<hrepeats; i+=1)
    for (var j=0; j<vrepeats; j+=1)    {
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
            
        draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,xpos+i*16,ypos+j*16);
    }
    
shader_reset();

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _text=ds_queue_head(global.notificationqueue);
draw_set_colour(c_white);

//For some godawful reason I made custom variables for the drawing coordinates, probably because I'm retarded
var text_x=xpos+hpadding;
var text_y=ypos+vpadding
draw_text(text_x,text_y,_text);

draw_set_alpha(1);