/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (global.hardpause)
	{
		image_speed=0;
		exit;
	}

if (place_meeting(x,y,parent_main_character))
	if (scr_inventory_check(obj_yellowKey) and !open)
		{
			scr_roomarray_set_secret_completed();
			global.edSpaceTwoEvents=scr_event_set_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.OPENEDYELLOWLOCK);
			var door=instance_create_layer(x,y,layer,obj_door);
			door.destination=mydestination; //Let's set a temp destination to next room
			door.image_yscale=image_yscale;
			open=true;
			scr_play_sound(snd_door_unlock,false,0);
		}
	
//Image speed selection
if (open and image_index<image_number-1)
	image_speed=1;
else
	image_speed=0;