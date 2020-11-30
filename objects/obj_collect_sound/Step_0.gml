/// @description Insert description here
// You can write your code in this editor

if !audio_is_playing(soundplaying)
	{
		with (obj_music)
			{
				audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
			}
			
		instance_destroy();
	}