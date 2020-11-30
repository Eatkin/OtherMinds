/// @description Insert description here
// You can write your code in this editor
if global.sound_fx_on=true
	{
		with (obj_music)
			{
				audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,250);
			}
	}

soundplaying=audio_play_sound(snd_collect_animation,0,false);
audio_sound_gain(soundplaying,global.sound_fx_volume*global.sound_fx_on,0);