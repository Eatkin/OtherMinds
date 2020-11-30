/// @description
// Inherit the parent event
event_inherited();

instance_create_layer(x,y,"Players",obj_smoke);

var vibamount;
var dist=distance_to_object(global.currentinstance);
var maxdist=128;
vibamount=1-min(1,dist/maxdist);
scr_set_vibration(vibamount,vibamount,1);