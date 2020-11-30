/// @description

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}

image_speed=1;

if (active==true)
	{
		exit;
	}
	
if (place_meeting(x,y,parent_main_character))
	{
		active=true;
		sprite_index=spr_flagpole_flapping;
		with (obj_timetrial)
			{
				trialended=true;
			}
	}