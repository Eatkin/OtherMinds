/// @description
// Inherit the parent event
event_inherited();

instance_create_layer(x+sprite_width*0.5,y,"Players",obj_smoke);

var vibamount;
var dist=distance_to_object(global.currentinstance);
var maxdist=128;
vibamount=1-min(1,dist/maxdist);
//1 frame so it doesn't stack
scr_set_vibration(vibamount,vibamount,1);