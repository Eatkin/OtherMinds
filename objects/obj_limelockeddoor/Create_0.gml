/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

open=false;
mydestination=rm_ochrehill_secret;
if (room==rm_ochrehill_secret)
	{
		mydestination=rm_ochrehill_3;
	}
image_speed=0;
if scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.UNLOCKED_DOOR)
	{
		image_index=image_number-1;
		var door=instance_create_layer(x,y,layer,obj_door);
		door.destination=mydestination;
		door.sprite_index=spr_ochrehilldoor;
		open=true;
	}
	
treasuremapcreated=false;

//Okay now we check if we have left the treasuremap behind
//Also make sure we're in the right room lololol
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.TREASURE_MAP)==true and scr_inventory_check(obj_treasure_map_2)==false and room==rm_ochrehill_3)
	{
		instance_create_layer(x-128,-64,"objects",obj_treasure_map_2);
		treasuremapcreated=true;
	}