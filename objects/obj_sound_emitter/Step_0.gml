/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if soundid!=noone
	{
		if hasplayedsound=0
			{
				hasplayedsound=1;
				if (mode==EMITTER.LOOP)
					{
						scr_play_sound(soundid,true,0);
					}
				else
					{
						scr_play_sound(soundid,false,0);
					}
			}
		if !audio_is_playing(soundplaying)
			{
				instance_destroy();
			}
		if mode=EMITTER.FADEOUT
			{
				gainoverride-=0.02;
				gainoverride=max(gainoverride,0);
			}
	}