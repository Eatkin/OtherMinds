/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

open=0;
mydestination=rm_Edcellar;
image_speed=0;
if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.OPENEDCELLAR)
	{
		image_index=image_number-1;
		var door=instance_create_layer(x,y,layer,obj_cellardoor);
		door.destination=mydestination;
		instance_destroy();
	}