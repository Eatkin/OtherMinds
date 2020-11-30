/// @description

draw_sprite(spr_demotext,0,imagex,imagey);
//var textheight=string_height("A"); //Monospaced font
//var spritewidth=sprite_get_width(spr_demotext);
var spriteheight=sprite_get_height(spr_demotext);
var textx=imagex;
var texty=imagey+spriteheight*0.5;


draw_set_halign(fa_center);
draw_set_valign(fa_top);
scr_draw_text_outlined(textx,texty,string(demonum)+" of "+string(demototal));