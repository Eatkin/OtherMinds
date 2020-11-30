/// @description Activate linked instance
// You can write your code in this editor

event_inherited();

if ((place_meeting(x,y,parent_possessable) or place_meeting(x,y,parent_push)) and linkedinstance!=noone)
	{
		if (image_index==0)
			{
				if (instance_exists(linkedinstance))	{
					if (mode==1 and !linkedinstance.activated)
						linkedinstance.activated=true;
					else if (mode!=1)
						linkedinstance.activated=linkedinstance.activated^1;
				}

				scr_play_sound(sound_clickon,0,0);
				image_index=1;
				var vibamount;
				var dist=distance_to_object(global.currentinstance);
				var maxdist=256;
				vibamount=1-min(1,dist/maxdist);
				scr_set_vibration(vibamount,vibamount,10);
			}
	}
else if (image_index==1)
	{
		scr_play_sound(sound_clickoff,0,0);
		image_index=0;
		var vibamount;
		var dist=distance_to_object(global.currentinstance);
		var maxdist=256;
		vibamount=1-min(1,dist/maxdist);
		scr_set_vibration(vibamount,vibamount,10);
	}