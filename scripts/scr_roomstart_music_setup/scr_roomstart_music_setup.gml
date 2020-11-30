//Created 06/11/19
//Late ipdated 06/11/19

//Just moving this to a script because I can never find it, its one hell of a script name logshfdsofsa

//I'm afraid this is just going to be really boring and tedious
var songnumber=-1;
switch(room)
	{
		#region menus and meta
		case room_setup:
		case rm_language_select:
			{
				songnumber=noone;
				break;
			}
		case rm_firsttime:
			{
				songnumber=noone;
				if controller_global.previous_room=rm_main_menu
					{
						songnumber=1;
					}
				break;
			}
		case rm_main_menu:
			{
				songnumber=1
				break;
			}
		#endregion
		#region Tutorials
		case room_Tutorials_1:
		case room_Tutorials_2:
		case room_Tutorials_3:
		case room_Tutorials_4:
		case room_Tutorials_5:
			{
				songnumber=12;
				break;
			}
		#endregion
		#region EdSpace Zone 1
		case room_EdSpace1_1:
		case rm_EdSpace1_1:
		case room_EdSpace1_2:
		case rm_EdSpace1_2:
		case room_EdSpace1_3:
		case rm_EdSpace1_3:
			{
				songnumber=0;
				break;
			}
		case rm_secret_tutorial:
		case rm_EdSpace1_4:
		case room_EdSpace1_4:
		case rm_EdSpace1_4_5:
			{
				songnumber=10;
				break;
			}
		case room_EdSpace1_5:
			{
				songnumber=noone; //Silence for the boss room
				if (scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED))
					songnumber=3;
				break;
			}
		case room_EdSpace1_6:
		case rm_EdSpace1_secret:
		case room_EdSpace1_7:
		case rm_EdSpace1_6:
			{
				songnumber=3;
				break;
			}
		#endregion
		#region Ed house
		case rm_Edbedroom:
		case rm_Edhallway:
		case rm_Edsparebedroom:
		case rm_Edbathroom:
		case rm_Edguestbedroom:
		case rm_Edkitchen:
		case rm_Edlivingroom:
			{
				songnumber=4;
				break;
			}
		case rm_Edgarden:
			{
				songnumber=6;
				break;
			}
		case rm_Edcellar:
			{
				songnumber=5;
				break;
			}
		#endregion
		#region Overworld
		case rm_overworld_edhouse:
		case rm_overworld_ochrehill:
		case rm_overworld_puzzlecave:
		case rm_puzzlecavechamber:
		case rm_overworld_outhouse:
			{
				songnumber=6;
				if (scr_isDark())
					songnumber=16;
				break;
			}
		case rm_mysterious_room:
			{
				songnumber=5;
				break;
			}
		case rm_overworld_officeblock:
			{
				songnumber=14;
				if (scr_isDark())
					songnumber=16;
				break;
			}
		#endregion
		#region Ochre Hill
		case rm_ochrehill_1:
		case rm_ochrehill_2:
		case rm_ochrehill_3:
		case rm_ochrehill_4:
		case rm_ochrehill_4OLD:
		case rm_ochrehill_5:
		case rm_ochrehill_6:
			{
				songnumber=7;
				break;
			}
		//Boss fight, music depends on event 
		case rm_ochrehill_7:
			{
				songnumber=noone;
				if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED)==true)
					{
						songnumber=8
					}
				break;
			}
		case rm_ochrehill_secret:
		case rm_ochrehill_8:
		case rm_ochrehill_9:
		case rm_ochrehill_9OLD:
		case rm_ochrehill_10:
		case rm_ochrehill_11:
		case rm_ochrehill_bonus:
			{
				songnumber=8;
				break;
			}
		#endregion
		#region Office
		case rm_office_floor_one:
		case rm_office_vent_room_one:
		case rm_office_vent_room_two:
		case rm_office_vent_room_three:
			{
				songnumber=13;
				break;
			}
		#endregion
		#region EdSpace Zone 2
		case rm_EdSpace2_1:
		case rm_EdSpace2_2:
		case rm_EdSpace2_3:
		case rm_EdSpace2_4:
		case rm_EdSpace2_5:
		case rm_EdSpace2_secret:
			songnumber=15;
			break;
		#endregion
		default:	
			{
				songnumber=noone;
				break;
			}
	}

if songnumber!=noone
	{
		var song=musicarray[MUSIC.SOUND_ID,songnumber];
		//This makes sure volume goes back up again if for some reason it is not full volume, eg when it has been faded out for picking up an object
		if (nowplayingsong==song)
			{
				audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
			}
		if (nowplayingsong!=song)
			{
				fadingout=nowplaying;
				fadingoutsong=nowplayingsong;
				audio_sound_gain(fadingout,0,500);
				nowplaying=audio_play_sound(song,0,false);
				nowplayingsong=song;
				//For some completely insane reason, this is in MILLI SECONDS!
				//WHY IS EVERYTHING MEASURED IN STEPS EXCEPT THIS
				//AHHHHHHHHHHHHHHHH
				audio_sound_gain(nowplaying,0,0);
				audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
				mainlooptime=musicarray[MUSIC.MAINLOOP,songnumber];
				loopendtime=musicarray[MUSIC.LOOPEND,songnumber];
			}
	}
else
	{
		fadingout=nowplaying;
		fadingoutsong=nowplayingsong;
		audio_sound_gain(fadingout,0,500);
		nowplaying=noone;
		nowplayingsong=-1;
	}