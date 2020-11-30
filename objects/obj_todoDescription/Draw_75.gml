/// @description

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
            
        draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,x+i*16,y+j*16);
    }
    
shader_reset();

//Text and text boundaries
var padding=6;
var maxwidth=hrepeats*16-padding*2;
var xx=x+padding;
var yy=y+padding;
var sep=string_height("A");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

draw_text_ext(xx,yy,text,sep,maxwidth);