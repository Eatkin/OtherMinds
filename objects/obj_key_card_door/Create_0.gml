/// @description

event_inherited();

active=false;
image_speed=0;

myblock=instance_create_layer(x,y,layer,obj_block);
scr_object_resize(myblock,sprite_width,sprite_height);

pitchoverride=0.4;
gainoverride=0.2;

delaymax=10;
delay=10;

popuptimermax=120;
popuptimer=popuptimermax;
poppingup=false;