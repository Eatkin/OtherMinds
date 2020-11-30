/// @description

draw_self();

var stopwatch=spr_stopwatch;
var text="x"+string(timetrialnumber);
var width=sprite_get_width(stopwatch)+string_width(text);
var xdraw=x+0.5*(sprite_width-width);
var ydraw=y+sprite_height*0.5;

draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_colour(c_white);
draw_sprite(stopwatch,0,xdraw,ydraw);
xdraw+=sprite_get_width(stopwatch);
draw_text(xdraw,ydraw,text);

//Reset alignment
draw_set_valign(fa_top);