/// @description

// Inherit the parent event
event_inherited();

image_speed=0;
myBlock=instance_create_layer(x,y,layer,obj_block_small);
activated=false;

delay=-1;
maxdelay=10;

//If we've collapsed the floor and hven't entered the gauntlet, auto-collapse the floor
if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.COLLAPSEDFLOOR) and !scr_event_check_complete(global.officeevents,OFFICEEVENTS.ENTEREDGAUNTLET))
	activated=true;