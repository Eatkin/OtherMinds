/// @description

//Draw a thin rectangle
draw_set_alpha(rectAlpha);
draw_set_colour(c_black);
draw_rectangle(0,0,480,270,false);
draw_set_alpha(1);

//Draw the logo
draw_sprite(spr_logo,0,240,270+yoffset*0.2);

draw_set_halign(fa_middle);
draw_set_valign(fa_top);
scr_draw_text_outlined(240,305+yoffset*0.2,credits)