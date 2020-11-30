/// @description

global.softpause=false;

with (obj_music)
	{
		if nowplaying!=noone
			{
				audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
			}
	}