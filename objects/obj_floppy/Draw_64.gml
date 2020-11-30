/// @description draw the floppy
// You can write your code in this editor

var screenheight=display_get_gui_height();
var y1;
var hudheight=sprite_get_height(spr_HUD_box);

//Define coordinates to draw at
y1=screenheight-hudheight*global.helpbar; //global.helpbar is 0 if turned off
var xdraw=16;
var ydraw=y1-48;

draw_sprite_ext(spr_floppy,0,xdraw,ydraw,1,1,0,c_white,alpha);