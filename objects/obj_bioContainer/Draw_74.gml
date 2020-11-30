/// @description

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
            
        draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,x+i*16,y+j*16);
    }
    
shader_reset();

var padding=6;
padding*=2;
var maxwidth=hrepeats*16-padding;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
var xx=x+padding*0.5;
var yy=y+padding;
var len=array_length_1d(text);
var yoffset=0;
var sep=string_height("A");
for (var i=0; i<len; i+=1)    {
    draw_text_ext(xx,yy+16*(i+yoffset),text[i],sep,maxwidth);
	
	if (string_width(text[i])>maxwidth)
		yoffset+=1;
}

//Draw sprite in the top right
//We want the sprite's top-right corner to be in line with the corner
var xx=x+(hrepeats-1)*16-sprite_get_width(mySpr)+sprite_get_xoffset(mySpr);
var yy=y+16+sprite_get_yoffset(mySpr);
draw_sprite(mySpr,sprImageIndex,xx,yy);