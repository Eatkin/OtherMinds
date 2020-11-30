/// @description just checks if the song needs refreshing

alarm[0]=loopchecktime;

var _pos=audio_sound_get_track_position(nowplaying);
if (_pos<loopendtime)
	exit;

//This will shift back by the length of the loop
var _newpos=mainlooptime+_pos-loopendtime;
audio_sound_set_track_position(nowplaying,_newpos);