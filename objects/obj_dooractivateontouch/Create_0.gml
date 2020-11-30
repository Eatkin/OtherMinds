/// @description Creates destination and active setting (to be overwritten)
// You can write your code in this editor
event_inherited();

//label=scr_return_text(234);
destination=noone;
active=0;
transitionobj=noone;

var arrowsprite=spr_arrow;
var width=sprite_get_width(arrowsprite);
var height=sprite_get_height(arrowsprite);
arrowsurf=surface_create(width,height);