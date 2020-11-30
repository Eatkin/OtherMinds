/// @description Insert description here
// You can write your code in this editor

draw_self();

//Draw the dotted gloop etc

var ydraw=ystart-96;
draw_sprite(spr_screen,-1,x+sprite_width*0.5-sprite_get_width(spr_screen)*0.5+4,ydraw);
var xdraw=x+sprite_width*0.5-0.5*(sprite_get_width(spr_gloop_dotted)+sprite_get_width(spr_times)+16);
draw_sprite(spr_gloop_dotted,-1,xdraw,ydraw);
xdraw+=sprite_get_width(spr_gloop_dotted)+8;
draw_sprite(spr_times,-1,xdraw,ydraw);
draw_set_colour(c_white);
xdraw+=sprite_get_width(spr_times)+8;
draw_sprite(spr_digital321,gloopcountdraw,xdraw,ydraw);