/// @description Spins
// You can write your code in this editor

event_inherited();

visible=true;

if global.hardpause=1
	{
		image_speed=0;
		exit;
	}
	
if (!audio_is_playing(soundplaying))
	{
		scr_play_sound(snd_sign_spin,1,0);
	}

if active=1
	{
		active=0
		if state=PlayerState.idle
			{
				if distance_to_object(global.currentinstance)<240
					{
						scr_set_vibration(1,1,10);
					}
				gainoverride=lerp(gainoverride,1,0.4);
				state=PlayerState.spinning;
				image_speed=1;
				//This makes sure it doesn't immediately stop
				image_index=floor(image_index)+1;
			}
	}

if state=PlayerState.spinning
	{
		gainoverride=lerp(gainoverride,1,0.4);
		//Stop spinning
		if floor((image_index+1)%11)=0
			{
				image_speed=0;
				state=PlayerState.idle;
				dir=floor((image_index+1)/11);
			}
		else
			{
				image_speed=1;
			}
	}
else
	{
		gainoverride=lerp(gainoverride,0,0.4);
	}
	
visible=false;