/// @description second check for position

var musicpos;
with (obj_music)
	{
		musicpos=audio_sound_get_track_position(nowplaying);
	}
audio_sound_set_track_position(drumtrackref,musicpos);