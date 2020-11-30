/// @description

theMusic=noone;
position=0;
musicOffset=0;
//fpb=30; //Frames per beat, nice and easy!
timeline_index=timeline_officegauntlet;
timeline_running=true;
timeline_speed=0; //We MANUALLY set the timeline
timeline_loop=false;

haspaused=false;
counter=0;

if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.GAUNTLET_COMPLETE)==false)
	{
		theMusic=audio_play_sound(mus_seabass,0,false);
		audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	}

if (global.checkpoint[0]==inst_6F853F63)
	{
		counter=2550;
		position=counter/30;
		for (var i=1; i<counter; i+=1)
			{
				timeline_moment_clear(timeline_index,i);
			}
		timeline_position=counter;
	}
else if (global.checkpoint[0]==inst_694D051F)
	{
		counter=4590;
		position=counter/30;
		for (var i=1; i<counter; i+=1)
			{
				timeline_moment_clear(timeline_index,i);
			}
		timeline_position=counter;
	}
else if (global.checkpoint[0]==inst_58991BD)
	{
		counter=206*30;
		position=206;
		for (var i=1; i<counter; i+=1)
			{
				timeline_moment_clear(timeline_index,i);
			}
		timeline_position=counter;
	}
	
if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.GAUNTLET_COMPLETE)==false and global.checkpoint[0]!=noone)
	{
		audio_sound_set_track_position(theMusic,musicOffset+counter/60);	
	}
	
alarm[0]=60; //Music resync