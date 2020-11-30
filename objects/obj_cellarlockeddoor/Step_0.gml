/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if global.hardpause=1
	{
		image_speed=0;
		exit;
	}

var player=instance_place(x,y,parent_main_character);
if player!=noone
	{
		if scr_inventory_check(obj_cellar_key) and open=0
			{
				scr_roomarray_set_secret_completed();
				global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.OPENEDCELLAR)
				var door=instance_create_layer(x,y,layer,obj_cellardoor);
				door.destination=mydestination; //Let's set a temp destination to next room
				open=1;
				scr_play_sound(snd_door_unlock,false,0);
			}
	}
	
//Image speed selection
if open=1 and image_index<image_number-1
	{
		image_speed=1;
	}
else
	{
		image_speed=0;
	}