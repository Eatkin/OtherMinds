/// @description loops

alarm[0]=loopchecktime;

var _pos=audio_sound_get_track_position(drumtrackref);
if _pos<loopend
	{
		exit;
	}

//This will shift back by the length of the loop
var musicpos;
with (obj_music)
	{
		musicpos=audio_sound_get_track_position(nowplaying);
	}
audio_sound_set_track_position(drumtrackref,musicpos);