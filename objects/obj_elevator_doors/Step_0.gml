/// @description

if (global.hardpause==true)
	{
		image_speed=0;
	}
	
if (activated==true and doorsclosed==false)
	{
		if (visible==false)
			{
				audio_play_sound(snd_elevator_close,0,false);
			}
		visible=true;
		image_speed=1;
		if (image_index>=image_number-1)
			{
				doorsclosed=true;
				image_speed=0;
			}
	}

if (doorsclosed==true)
	{
		global.softpause=true;
		if (doorsopening==true and !instance_exists(obj_transition))
			{
				if (image_speed!=-1)
					{
						var snd=audio_play_sound(snd_elevator_close,false,0);
						audio_sound_pitch(snd,1.1);
					}
				image_speed=-1;
				if (image_index<1)
					{
						doorsopening=false;
						doorsclosed=false;
						activated=false;
						visible=false;
						image_speed=0;
						global.softpause=false;
					}
			}
	}