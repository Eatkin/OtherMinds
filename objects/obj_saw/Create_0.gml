/// @description
dir=1; //Right
xbound=64; //Jiggle room left and right
maxspeed=3;
xspeed=0;

myspikes=instance_create_layer(x,y,layer,obj_spikes);
myspikes.visible=false;
scr_object_resize(myspikes,bbox_right-bbox_left,bbox_bottom-bbox_top);

myspikes.x=bbox_left;
myspikes.y=bbox_top;

event_inherited();