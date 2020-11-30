/// @description smoke creation

// Inherit the parent event
event_inherited();

instance_create_layer(x,y,"Players",obj_smoke);

//Here we set vib regardless because its a response to the boss being damaged
scr_set_vibration(1,1,15);