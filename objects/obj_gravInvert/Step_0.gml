/// @description

if (global.hardpause)
	exit;
	
if (activated)
	{
		if (global.gravdirection==90)
			scr_gravityInvert();
			
		if (time==-1)
			time=maxTime;
		else
			time-=1;
			
		//Click
		if (time%60==0)
			audio_play_sound(snd_morse_long,0,false);
			
		if (time<240)
			{
				if (time<120)
					{
						if (time%15==0)
							audio_play_sound(snd_morse_short,0,false);
					}
				else if (time%30==0)
					audio_play_sound(snd_morse_short,0,false);
			}
		
		if (time==-1)
			{
				activated=false;
				scr_gravityInvert();
			}
	}