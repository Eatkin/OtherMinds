/// @description Stop audio and resume background music to normal level

if audio_is_playing(drumtrackref)
	{
		audio_stop_sound(drumtrackref);
	}
if audio_is_playing(soloref)
	{
		audio_stop_sound(soloref);
	}
	
with (obj_music)
	{
		audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
	}