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

//Now we draw our options
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Header
draw_text(x+hrepeats*8,y+16,headerText);

draw_set_halign(fa_left);
//Options - need some column alignment
/*Eg
help bar enabled        x
Difficulty                < Easy >
Vibration enabled        x
*/
var len=array_length_1d(option);
var maxLength=0;
for (var i=0; i<len; i+=1)    {
    draw_text(x+32,y+32+16*i,option[i]);
    maxLength=max(maxLength,string_width(option[i]));
}

var hoffset=ceil(2+maxLength/16)*16;
//Sprites
var spr=(global.helpbar)    ?    spr_tick    :    spr_cross;
draw_sprite(spr,0,x+hoffset,y+32);
spr=(global.vibration)    ?    spr_tick    :    spr_cross;
draw_sprite(spr,0,x+hoffset,y+64);

//Difficulty text
var diffText="";
if (global.difficulty>DIFFICULTY.EXTRAEASY)
    diffText+="< ";

if (global.difficulty!=DIFFICULTY.NORMAL)
    diffText+=scr_return_text(60+global.difficulty-(global.difficulty>DIFFICULTY.NORMAL));        //Worst code ever
else
    diffText+=scr_return_text(233);        //Yeah I'm not sure why this is different

if (global.difficulty<DIFFICULTY.EXTRAHARD)
    diffText+=" >";
    
draw_text(x+hoffset,y+48,diffText);

//Alignment reset
draw_set_valign(fa_top);

draw_sprite(spr_menuChevron,0,chevronX,chevronY-5);        //-5 accounts for sprite height