/// @description This is really boring

event_inherited();

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}

if (active==true)
	{
		if (poppingup==true)
			{
				image_speed=0;
				popuptimer=popuptimermax;
				poppingup=false;
			}
		if (delay==delaymax)
			{
				scr_play_sound(snd_slowdown,false,0);
			}
		delay-=1;
		if (delay>0)
			{
				exit;
			}
		image_speed=1;
		if (image_index>image_number-1)
			{
				//Deactivate collision and count down to moving up again
				image_speed=0;
				instance_deactivate_object(myblock);
				popuptimer-=1;
				if (popuptimer<0)
					{
						poppingup=true;
						active=false;
						delay=delaymax;
						popuptimer=popuptimermax;
						scr_play_sound(snd_speedup,false,0);
					}
			}
	}

//move up;
if (poppingup==true)
	{
		image_speed=-1;
		if (image_index<1)
			{
				image_speed=0;
				if (!place_meeting(x,y,parent_possessable) and !place_meeting(x,y,obj_sage))
					{
						poppingup=false;
						instance_activate_object(myblock);
						image_index=0;
					}
			}
	}