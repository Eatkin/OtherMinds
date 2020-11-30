//Created 18/07/19
//Last updated 04/08/19

//Plays music but only if music is turned on
//arg0 sound

//Set the volume basd on music volume
with (obj_music)
	{
		fadingout=nowplaying;
		audio_sound_gain(fadingout,0,500);
		nowplaying=audio_play_sound(argument0,0,false);
		nowplayingsong=argument0; //This should fix that bug I had
		audio_sound_gain(nowplaying,0,0);
		audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
		//Find looping information
		for (var i=0; i<array_length_2d(musicarray,0); i+=1)
			{
				if musicarray[MUSIC.SOUND_ID,i]=argument0
					{
						mainlooptime=musicarray[MUSIC.MAINLOOP,i];
						loopendtime=musicarray[MUSIC.LOOPEND,i];
						break;
					}
			}
	}