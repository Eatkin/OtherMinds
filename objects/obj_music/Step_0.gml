/// @description Change song
// You can write your code in this editor

//Also will handle looping eventually

	
if fadingout!=noone
	{
		if audio_sound_get_gain(fadingout)=0
			{
				audio_stop_sound(fadingout);
				fadingout=noone;
			}
	}