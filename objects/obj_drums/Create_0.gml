/// @description Set up gain and tracks and stuff

event_inherited();

fadingout=false;
fadingin=false;

label=scr_return_text(243);
active=false;
drumtrack=mus_drumtrack1;
drumsolo=mus_drumtrack2;

//Sound and looping information
drumtrackref=audio_play_sound(drumtrack,0,false);
loopend=33.338;
soloref=noone;
//Just realised this is supposed to fade in, not suddenly be loud and fade to the correct volume
audio_sound_gain(drumtrackref,0,0);
var time=1000;
audio_sound_gain(drumtrackref,global.music_volume*global.music_on,time);

var musicpos;
with (obj_music)
	{
		musicpos=audio_sound_get_track_position(nowplaying);
	}
audio_sound_set_track_position(drumtrackref,musicpos);

alarm[1]=1;

loopchecktime=15;
alarm[0]=loopchecktime;