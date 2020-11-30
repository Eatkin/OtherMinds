/// @description Activate linked instance
// You can write your code in this editor

event_inherited();

if (place_meeting(x,y,parent_possessable) or place_meeting(x,y,parent_push)) and linkedinstance!=noone
	{
		if image_index=0
			{
				scr_play_sound(sound_clickon,0,0);
				image_index=1;
				if (instance_exists(linkedinstance))
					linkedinstance.activated+=0.5;
				if scr_on_camera(global.currentinstance)
					{
						scr_set_vibration(1,1,10);
					}
			}
	}
else if image_index=1
	{
		if (instance_exists(linkedinstance))
			if (linkedinstance.activated==0.5)
					linkedinstance.activated=0;
					
		scr_play_sound(sound_clickoff,0,0);
		image_index=0;
		if scr_on_camera(global.currentinstance)
			{
				scr_set_vibration(1,1,10);
			}
	}