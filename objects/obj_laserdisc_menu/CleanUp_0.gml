/// @description

if surface_exists(diarysurface)
	{
		surface_free(diarysurface);
	}

if (surface_exists(imagesurface))
	{
		surface_free(imagesurface);
	}
	
global.softpause=false;

with (obj_music)
	{
		if nowplaying!=noone
			{
				audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
			}
	}