/// @description Pooping information and interaction information

// Inherit the parent event
event_inherited();

//Play solo
if active=1
	{
		active=0;
		if soloref=noone
			{
				soloref=audio_play_sound(drumsolo,0,0);
				audio_sound_gain(soloref,0,0);
				audio_sound_gain(soloref,global.music_volume*global.music_on,500);
				label=scr_return_text(244);
			}
		else
			{
				audio_sound_gain(soloref,0,500);
				soloref=noone;
				label=scr_return_text(243)
			}
	}

//We'll force the now playing and drum track to set their gain to 0.1*global.music_volume*global.music_on until the drum solo is played
if audio_is_playing(drumsolo)
	{	
		var gain=audio_sound_get_gain(drumtrackref);
		var gaintarget=0.1*global.music_volume*global.music_on;
		var volume=lerp(gain,gaintarget,0.1);
		//Set the volumes
		audio_sound_gain(drumtrackref,volume,0);
		with (obj_music)
			{
				audio_sound_gain(nowplaying,volume,0);
			}
	}
else if label=scr_return_text(244)
	{
		soloref=noone;
		label=scr_return_text(243);
		volume=global.music_volume*global.music_on;
		//Set the volumes
		if !instance_exists(obj_dream_diary_menu)	
			{
				audio_sound_gain(drumtrackref,volume,500);
				with (obj_music)
					{
						audio_sound_gain(nowplaying,volume,500);
					}
			}
	}

//Deal with pausing
if (global.hardpause=true or instance_exists(obj_dream_diary_menu)) and fadingout=false
	{
		//Unpause because pausing pauses it then reset the position
		if audio_is_paused(drumtrackref)
			{
				audio_resume_sound(drumtrackref);
				var musicpos;
				with (obj_music)
					{
						musicpos=audio_sound_get_track_position(nowplaying);
					}
				audio_sound_set_track_position(drumtrackref,musicpos);
			}
		audio_sound_gain(drumtrackref,global.music_volume*global.music_on*0.1,500);
		fadingout=true;
		fadingin=false;
	}
if global.hardpause=false and !instance_exists(obj_dream_diary_menu) and fadingin=false
	{
		audio_sound_gain(drumtrackref,global.music_volume*global.music_on,500);
		fadingin=true;
		fadingout=false;
	}