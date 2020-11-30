/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

open=0;
mydestination=rm_EdSpace1_secret;
image_speed=0;
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.OPENEDGREENLOCK)
	{
		image_index=image_number-1;
		var door=instance_create_layer(x,y,layer,obj_door);
		door.destination=mydestination;
	}