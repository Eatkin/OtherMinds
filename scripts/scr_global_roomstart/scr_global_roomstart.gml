//Created 21/07/19
//Last updated 09/09/19

//Start with gravity pointing down
if (global.gravdirection==-90)
	scr_gravityInvert();

//Clear the notification queue IF we're in a disallowed room
if (scr_is_disallowed_room(room))
	ds_queue_clear(global.notificationqueue);
	
//Have a 1/6 chance of re-rolling rng value
if (global.attract==false)
	{
		if (irandom(5)==0)
			{
				show_debug_message("rng reroll");
				global.rng=irandom(3);
			}
	}

alarm[1]=1;
room_speed=60;
//I might want to add 'level sets' to group levels

//I'm going to put this here as I plan on allowing you to use different characters
var character=global.maincharacter;
//FAILSAFE! Gamemaker always reindexes things which is annoying
if (object_get_parent(character)!=parent_main_character)
	character=obj_Ed;

//So we go through each room
//Each room decides where to spawn Ed
//Any rooms not specifically outlined in the switch statement automatically turn off the transition
//They also don't spawn Ed
var xspawn, yspawn;
var createtransition=1;
var spawnEd=1;
var createcam=1;
var camzoom=false;
var reversedir=false; //Set directionfacing to backwards
var canleavelevel=true;
var updatedeathcount=true; //This increases local deaths with exclusions
var timetrial=false;
var teleportedin=false; //Have you teleported over from another room?
var sageenabled=true;
var elevator=false;

//A bunch of specifics
var exploreOchreComplete=false;

switch(room)
	{
		//All the rooms that exist without gameplay
		case room_setup:
		case rm_firsttime:
		case rm_language_select:
		case rm_main_menu:
		case room_credits:
		case rm_splash:
		case rm_loadGame:
		case rm_newGame:
		case rm_loadAttract:
			{
				spawnEd=false;
				createtransition=false;
				//Dummy object to be the global instance on the title screen to prevent 5 million crashes
				var dummy=instance_create_layer(0,0,layer,obj_dummy);
				global.currentinstance=dummy;
				updatedeathcount=false;
				break;
			}
		#region TUTORIALS
		case room_Tutorials_1:
			{
				if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)=false
					{
						canleavelevel=false;
					}
				else if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE)=false
					{
						global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE);
						scr_queue_dialogue_box(scr_return_text(293));
					}
				xspawn=224;
				yspawn=592;
				if (previous_room==room_Tutorials_2)
					{
						reversedir=true;
						xspawn=1984;
						yspawn=464;
					}
					sageenabled=false;
				break;
			}
		case room_Tutorials_2:
			{
				if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)=false
					{
						canleavelevel=false;
					}
				xspawn=112;
				yspawn=592;
				if (previous_room==room_Tutorials_3)
					{
						reversedir=true;
						xspawn=944;
						yspawn=528;
					}
				sageenabled=false;
				break;
			}
		case room_Tutorials_3:
			{
				if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)=false
					{
						canleavelevel=false;
					}
				xspawn=112;
				yspawn=416;
				if (previous_room==room_Tutorials_4)
					{
						reversedir=true;
						xspawn=896;
						yspawn=480;
					}
				sageenabled=false;
				break;
			}
		case room_Tutorials_4:
			{
				if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)=false
					{
						canleavelevel=false;
					}
				xspawn=192;
				yspawn=480;
				if (previous_room==room_Tutorials_5)
					{
						reversedir=true;
						xspawn=960;
						yspawn=256;
					}
				break;
			}
		case room_Tutorials_5:
			{
				if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)=false
					{
						canleavelevel=false;
					}
				xspawn=144;
				yspawn=528;
				break;
			}
		#endregion
		
		#region EdSpace Zone 1
		case rm_EdSpace1_1:
			xspawn=48;
			yspawn=576;
			
			if (previous_room==rm_EdSpace1_2)	{
				xspawn=1488;
				yspawn=96;
				reversedir=true;
			}
			
			if (previous_room==rm_EdSpace1_secret)	{
				xspawn=48;
				yspawn=128;
			}
			
			//Handle cutscene creation and stuff
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
				
			instance_create_layer(0,0,layer,obj_EdSpace1_1CutsceneCreator);
			break;
			
		case rm_EdSpace1_2:
			xspawn=64;
			yspawn=144;
			
			if (previous_room==rm_EdSpace1_3)	{
				xspawn=1472;
				yspawn=560;
				reversedir=true;
			}
			
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace1_3:
			xspawn=64;
			yspawn=576;
			
			if (previous_room==rm_EdSpace1_4)	{
				xspawn=1488;
				yspawn=528;
				reversedir=true;
			}
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace1_4:
			xspawn=128;
			yspawn=672;
			
			if (previous_room==rm_EdSpace1_4_5)	{
				xspawn=1408;
				yspawn=352;
				reversedir=true;
			}
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace1_4_5:
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
				
			xspawn=80;
			yspawn=640;
			
			if (previous_room==room_EdSpace1_5)	{
				xspawn=704
				yspawn=384;
				reversedir=true;
			}
			break;
		
		case room_EdSpace1_5:
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			xspawn=32;
			yspawn=640;
			
			if (previous_room=rm_EdSpace1_6)	{
				xspawn=1344;
				yspawn=592;
				reversedir=true;
			}
			break;
			
		case rm_EdSpace1_6:
			xspawn=576;
			yspawn=368;
			reversedir=true;
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			break;
		
		case rm_EdSpace1_secret:
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
				canleavelevel=false;
			xspawn=96;
			yspawn=592;
			break;
		#endregion
		
		#region Ed's House
		case rm_Edbedroom:
			{
				canleavelevel=false;
				xspawn=188;
				yspawn=156;
				if (previous_room==rm_EdSpace1_6 or previous_room==rm_EdSpace2_6)
					{
						xspawn=304;
						reversedir=true;
						createtransition=false;
					}
				if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))
					camzoom=true;
				break;
			}
		case rm_Edhallway:
			{
				canleavelevel=false;
				//Default by the front door
				xspawn=144;
				yspawn=172;
				if previous_room=rm_Edbedroom
					{
						xspawn=192;
						yspawn=108;
					}
				if previous_room=rm_Edsparebedroom
					{
						xspawn=140;
						yspawn=108;
					}
				if previous_room=rm_Edbathroom
					{
						xspawn=338;
						yspawn=108;
						reversedir=true;
					}
				if previous_room=rm_Edguestbedroom
					{
						xspawn=232;
						yspawn=108;
					}
				if previous_room=rm_Edkitchen
					{
						xspawn=331;
						yspawn=172;
						reversedir=true;
					}
				if previous_room=rm_Edlivingroom
					{
						xspawn=246;
						yspawn=172;
					}
				camzoom=true;
				break;
			}
		case rm_Edsparebedroom:
			{
				canleavelevel=false;
				xspawn=272;
				yspawn=156;
				reversedir=true;
				camzoom=true;
				break;
			}
		case rm_Edbathroom:
			{
				canleavelevel=false;
				xspawn=180;
				yspawn=156;
				camzoom=true;
				break;
			}
		case rm_Edguestbedroom:
			{
				xspawn=303;
				yspawn=156;
				camzoom=true;
				reversedir=true;
				break;
			}
		case rm_Edkitchen:
			{
				canleavelevel=false;
				xspawn=173;
				yspawn=156;
				camzoom=true;
				if previous_room=rm_Edgarden
					{
						xspawn=290;
						reversedir=true;
					}
				break;
			}
		case rm_Edlivingroom:	
			{
				canleavelevel=false;
				xspawn=392;
				yspawn=156;
				camzoom=true;
				break;
			}
		case rm_Edgarden:
			{
				canleavelevel=false;
				xspawn=41;
				yspawn=240;
				//camzoom=true;		//Turning this off because the level's kinda big
				if previous_room=rm_Edcellar
					{
						xspawn=88;
						yspawn=264;
					}
				if (previous_room==rm_ochrehill_bonus)
					{
						xspawn=920;
						yspawn=234
						reversedir=true;
						teleportedin=true;
						//Update S-rocks dialogue for future (it's possible the player will find the teleporter before returning proper)
						if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.TALKTOSENTIENTROCK)=true)
							{
								global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.LEFTSENTIENTROCK);
							}
					}
				break;
			}
		case rm_Edcellar:
			{
				canleavelevel=false;
				xspawn=240;
				yspawn=80;
				camzoom=true;
				break;
			}
		#endregion
		
		#region overworld
		case rm_overworld_edhouse:
			{
				xspawn=480;
				yspawn=240;
				if previous_room=rm_overworld_ochrehill
					{
						xspawn=48;
						yspawn=432;
					}
				if previous_room=rm_overworld_outhouse
					{
						xspawn=928;
						yspawn=416;
						reversedir=true;
					}
				break;
			}
		case rm_overworld_ochrehill:
			{
				xspawn=912;
				yspawn=432;
				if previous_room=rm_overworld_edhouse
					{
						reversedir=true;
					}
				if previous_room=rm_overworld_puzzlecave
					{
						xspawn=48;
						yspawn=544;
					}
				if previous_room=rm_ochrehill_1
					{
						xspawn=32;
						yspawn=160;
					}
				break;
			}
		case rm_overworld_puzzlecave:
			{
				xspawn=912;
				yspawn=176;
				if previous_room=rm_overworld_ochrehill
					{
						reversedir=true;
					}
				if previous_room=rm_puzzlecavechamber
					{
						xspawn=64;
						yspawn=240;
					}
				global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.ENTEREDPUZZLECAVE);
				break;
			}
		case rm_puzzlecavechamber:
			{
				xspawn=432;
				yspawn=480;
				reversedir=true;
				break;
			}
		case rm_overworld_outhouse:
			{
				xspawn=32;
				yspawn=432;
				if previous_room=rm_inside_outhouse
					{
						xspawn=264;
						yspawn=416;
					}
				if (previous_room==rm_mysterious_room)
					{
						xspawn=392;
						yspawn=512;
					}
				if (previous_room=rm_overworld_officeblock)
					{
						reversedir=true;
						xspawn=576;
						yspawn=432;
					}
				break;
			}
		case rm_overworld_officeblock:
			{
				xspawn=32;
				yspawn=432;
				if (previous_room==rm_office_reception)
					{
						reversedir=true;
						xspawn=440;
						yspawn=368;
					}
				if (previous_room==rm_officeGauntletEscape)
					{
						reversedir=true;
						xspawn=576;
						yspawn=528;
					}
				break;
			}
		case rm_inside_outhouse:
			{
				xspawn=256;
				yspawn=152;
				reversedir=true;
				break;
			}
		case rm_mysterious_room:
			{
				xspawn=48;
				yspawn=224;
				if (previous_room==rm_EdSpace1_Rhythm)
					{
						xspawn=336;
						yspawn=96;
					}
				if (previous_room==rm_Ochre_Rhythm)
					{
						xspawn=656;
						yspawn=96;
					}
				if (previous_room==rm_EdSpace2_Rhythm)	{
					xspawn=976;
					yspawn=96;
				}
				if (previous_room==rm_whiteRhythm)	{
					xspawn=1296;
					yspawn=96;
				}
				if (previous_room==rm_endTimes)	{
					xspawn=5040;
					yspawn=192;
					reversedir=true;
				}
				
				#region long list from archived levels!
				if (previous_room==room_EdSpace1_1)	{
					xspawn=3296;
					yspawn=176;
				}
				if (previous_room==room_EdSpace1_2)	{
					xspawn=3408;
					yspawn=176;
				}
				if (previous_room==room_EdSpace1_3)	{
					xspawn=3520;
					yspawn=176;
				}
				if (previous_room==room_EdSpace1_4)	{
					xspawn=3632;
					yspawn=176;
				}
				if (previous_room==room_EdSpace1_6)	{
					xspawn=3744;
					yspawn=176;
				}
				if (previous_room==room_EdSpace1_7)	{
					xspawn=3856;
					yspawn=176;
				}
				if (previous_room==rm_ochrehill_4OLD)	{
					xspawn=4192;
					yspawn=160;
				}
				if (previous_room==rm_ochrehill_9OLD)	{
					xspawn=4352;
					yspawn=160;
				}
				if (previous_room==rm_ochrehill_10)	{
					xspawn=4544;
					yspawn=192;
				}
				if (previous_room==rm_secret_tutorial)	{
					xspawn=4832;
					yspawn=192;
				}
				#endregion
				break;
			}
		case rm_endTimes:
			xspawn=32;
			yspawn=192;
			break;
		#endregion
		
		#region ochre hill
		case rm_ochrehill_1:
			{
				xspawn=928;
				yspawn=928;
				if previous_room=rm_overworld_ochrehill
					{
						reversedir=true;
					}
				if previous_room=rm_ochrehill_2
					{
						xspawn=32;
						yspawn=320;
					}
				break;
			}
		case rm_ochrehill_2:
			{
				xspawn=448;
				yspawn=416;
				if previous_room=rm_ochrehill_1
					{
						reversedir=true;
					}
				if previous_room=rm_ochrehill_3
					{
						xspawn=32;
						yspawn=416;
					}
				if (previous_room==rm_ochrehill_11)
					{
						xspawn=48;
						yspawn=32;
						global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.OCHREHILLCOMPLETE);
						exploreOchreComplete=true;
					}
				break;
			}
		case rm_ochrehill_3:
			{
				xspawn=928;
				yspawn=144;
				reversedir=true;
				if previous_room=rm_ochrehill_4
					{
						xspawn=32;
						yspawn=112;
						reversedir=false;
					}
				if previous_room=rm_ochrehill_secret
					{
						xspawn=368;
						yspawn=64;
					}
				break;
			}
		case rm_ochrehill_4:
			{
				xspawn=928;
				yspawn=128;
				reversedir=true;
				if (previous_room==rm_ochrehill_5)
					{
						xspawn=32;
						yspawn=800;
						reversedir=false;
					}
				break;
			}
		case rm_ochrehill_5:
			{
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.OCHRE_5_REACHED);
				xspawn=928;
				yspawn=496;
				reversedir=true;
				if (previous_room==rm_ochrehill_6)
					{
						xspawn=32;
						yspawn=96;
						reversedir=false;
					}
				break;
			}
		case rm_ochrehill_6:
			{
				xspawn=928;
				yspawn=80;
				reversedir=true;
				if (previous_room==rm_ochrehill_7)
					{
						xspawn=32;
						yspawn=112;
						reversedir=false;
					}
				break;
			}
		case rm_ochrehill_secret:
			{
				xspawn=80;
				yspawn=464;
				break;
			}
		case rm_ochrehill_7:
			{
				//Uncomment this to set hep bee as undefeated
				//Note you'll have to die first before she respawns for some reason
				//global.ochre_events=scr_event_set_incomplete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED)
				xspawn=928;
				yspawn=1520;
				reversedir=true;
				if (previous_room==rm_ochrehill_8)
					{
						xspawn=928;
						yspawn=144;
					}
				break;
			}
		case rm_ochrehill_8:
			{
				xspawn=32;
				yspawn=464;
				if (previous_room==rm_ochrehill_9)
					{
						xspawn=1888;
						yspawn=384;
						reversedir=true;
					}
				break;
			}
		case rm_ochrehill_9:
			{
				xspawn=32;
				yspawn=368;
				if (previous_room==rm_ochrehill_bonus)
					{
						xspawn=1888;
						yspawn=320;
						reversedir=true;
						//Update S-rocks dialogue for future
						if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.TALKTOSENTIENTROCK)=true)
							{
								global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.LEFTSENTIENTROCK);
							}
					}
				break;
			}
		case rm_ochrehill_11:
			{
				xspawn=32;
				yspawn=448;
				//Update S-rocks dialogue for future
				if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.TALKTOSENTIENTROCK)=true)
					{
						global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.LEFTSENTIENTROCK);
					}
				break;
			}
		case rm_ochrehill_bonus:
			{
				xspawn=32;
				yspawn=176;
				if (previous_room==rm_Edgarden)
					{
						xspawn=920;
						yspawn=490;
						reversedir=true;
						teleportedin=true;
					}
				if (previous_room==rm_ochrehill_11)	{
					xspawn=1040;
					yspawn=496;
					reversedir=true;
				}
				break;
			}
		#endregion
		
		#region challenges
		case rm_EdSpace_z1_challenge:
			{
				xspawn=110;
				yspawn=1360;
				timetrial=true;
				canleavelevel=false;
				break;
			}
		case rm_OchreHill_challenge:
			{
				xspawn=32;
				yspawn=656;
				timetrial=true;
				canleavelevel=false;
				break;
			}
		case rm_EdSpace_z2_challenge:
			xspawn=176;
			yspawn=320;
			timetrial=true;
			canleavelevel=false;
			break;
		#endregion
		
		#region office block
		case rm_office_reception:
			{
				xspawn=203;
				yspawn=352;
				if (previous_room!=rm_overworld_officeblock)
					{
						elevator=true;
						reversedir=true;
						xspawn=392;
					}
				break;
			}
		case rm_office_floor_one:
			{
				xspawn=376;
				yspawn=352;
				reversedir=true;
				elevator=true;
				if (previous_room==rm_office_vent_room_one)
					{
						reversedir=false;
						elevator=false;
						xspawn=32;
						yspawn=112;
					}
				if (previous_room==rm_office_vent_room_two)
					{
						xspawn=576;
						yspawn=80;
						elevator=false;
					}
				if (previous_room==rm_office_vent_room_three)	
					{
						xspawn=32;
						yspawn=560;
						elevator=false;
						reversedir=false;
					}
				break;
			}
		case rm_office_vent_room_one:
			{
				xspawn=1184;
				yspawn=624;
				reversedir=true;
				break;
			}
		case rm_office_vent_room_two:
			{
				xspawn=32;
				yspawn=592;
				break;
			}
		case rm_office_vent_room_three:
			{
				xspawn=1184;
				yspawn=816;
				reversedir=true;
				break;
			}
		case rm_office_floor_two:
			{
				xspawn=392;
				yspawn=352;
				reversedir=true;
				elevator=true;
				if (previous_room==rm_office_dr_ds_office)
					{
						elevator=false;
						reversedir=false;
						xspawn=32;
						yspawn=352;
					}
				break;
			}
		case rm_office_dr_ds_office:
			{
				xspawn=576;
				yspawn=336;
				reversedir=true;
				canleavelevel=false;		//Stops you being able to escape after collapsing the floor lol
				
				//If we've collapsed the floor and not entered the gauntlet, move Ed so the player can't just skip it
				if (!scr_event_check_complete(global.officeevents,OFFICEEVENTS.ENTEREDGAUNTLET) and scr_event_check_complete(global.officeevents,OFFICEEVENTS.COLLAPSEDFLOOR))	{
					xspawn=256;
					reversedir=false;
				}
				break;
			}
		case rm_office_gauntlet:
			{
				xspawn=240;
				yspawn=16;
				if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.GAUNTLET_COMPLETE)==false)
					{
						canleavelevel=false;
					}
				if (previous_room==rm_officeGauntletEscape)
					{
						xspawn=6048;
						yspawn=64;
						reversedir=true;
					}
				break;
			}
		case rm_officeGauntletEscape:
			{
				xspawn=32;
				yspawn=192;
				if (previous_room==rm_overworld_officeblock)
					{
						yspawn=1968;
					}
				break;
			}
		case rm_office_new_ds_office:
			{
				xspawn=808;
				yspawn=352;
				reversedir=true;
				elevator=true;
				break;
			}
		#endregion
		
		#region EdSpace Z2
		case rm_EdSpace2_3:
			xspawn=64;
			yspawn=880;
			if (previous_room==rm_EdSpace2_2)
				{
					xspawn=904;
					yspawn=880;
					reversedir=true;
				}
			if (previous_room==rm_EdSpace2_secret)
				{
					xspawn=192;
					yspawn=384;
				}
				
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			else if (!scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE))
				{
					global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE);
					scr_queue_dialogue_box(scr_return_text(293));
				}
				
			//Also discover "Wake up part 2"
			scr_todo_discover(23);
			break;
		case rm_EdSpace2_2:
			xspawn=304;
			yspawn=144;
			reversedir=true;
			if (previous_room==rm_EdSpace2_4)
				{
					xspawn=752;
					reversedir=false;
				}
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
		case rm_EdSpace2_4:
			xspawn=896;
			yspawn=800;
			if (previous_room==rm_EdSpace2_5)
				yspawn=320;
				
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
		case rm_EdSpace2_5:
			xspawn=736;
			yspawn=976;
			if (previous_room==rm_EdSpace2_1)
				{
					xspawn=272;
					reversedir=true;
				}
				
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace2_1:
			xspawn=64;
			yspawn=720;
			if (previous_room==rm_EdSpace2_boss)
				yspawn=576;
				
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace2_boss:
			xspawn=144;
			yspawn=480;
			
			if (previous_room==rm_EdSpace2_6)
				{
					xspawn=432;
					yspawn=244;
				}
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
			
		case rm_EdSpace2_6:
			xspawn=80;
			yspawn=96;
			scr_gravityInvert();
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
				
			break;
			
		case rm_EdSpace2_secret:
			xspawn=48;
			yspawn=656;
			
			if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
				canleavelevel=false;
			break;
			
		#endregion
		
		#region Rhythm challenges
		case rm_EdSpace1_Rhythm:
			xspawn=96;
			yspawn=128;
			break;
			
		case rm_Ochre_Rhythm:
		case rm_whiteRhythm:
			xspawn=144;
			yspawn=224;
			break;
			
		case rm_EdSpace2_Rhythm:
			xspawn=144;
			yspawn=784;
			break;
		#endregion
		
		#region EDSPACE1 (ALPHA)
		case rm_secret_tutorial:
			{
				xspawn=240;
				yspawn=464;
				break;
			}
		case room_EdSpace1_1:
			{
				//Pop in some conditionals for what previous_room is to change coordinates
				xspawn=32;
				yspawn=688;
				break;
			}
		case room_EdSpace1_2:
			{
				xspawn=112;
				yspawn=1408;
				break;
			}
		case room_EdSpace1_3:
			{
				xspawn=576;
				yspawn=1392;
				break;
			}
		case room_EdSpace1_4:
			{
				//This also sets a flag in events for being able to return to EdSpace 3
				//global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COMPLETEDEDSPACETHREE);
				xspawn=1008;
				yspawn=624;
				
				/*if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.EDSPACEFOUR_ROOMFOURCOMPLETE)
					{
						inst_47FBF9A1.activated=1;
					}
				*/
				break;
			}
		case room_EdSpace1_6:
			{
				xspawn=32;
				yspawn=608;
				break;
			}
		case room_EdSpace1_7:
			{
				xspawn=528;
				yspawn=272;
				break;
			}
		#endregion END OF EDSPACE 1
		
		#region Ochre Hill ALPH
		case rm_ochrehill_4OLD:
			xspawn=928;
			yspawn=128;
			break;
			
		case rm_ochrehill_9OLD:
			xspawn=32;
			yspawn=368;
			break;
			
		case rm_ochrehill_10:
			xspawn=32;
			yspawn=400;
			break;
		#endregion
		
		default:
			{
				createtransition=0;
				spawnEd=0;
				createcam=0;
			}
	}
	
if (timetrial==true)
	{
		instance_create_layer(0,0,"controllers",obj_timetrial);
	}

if (updatedeathcount==true)
	{
		//Dumb variable name update
		global.localdeaths+=1;
	}
//These are in a very particular order!
if (spawnEd==true)
	{
		var Ed=instance_create_layer(xspawn,yspawn,"players",character);
		global.currentinstance=Ed;
		
		//Complete the 'explore ochre hill' event
		if (exploreOchreComplete)
			with (global.currentinstance)
				scr_todo_complete(12);
				
		if (teleportedin==true)
			{
				with (Ed)
					{
						state=PlayerState.teleport;
						sprite_index=sprite_teleport_backwards;
						image_index=0;
						image_speed=1;
					}
			}
			
		if (sageenabled==false)
			{
				Ed.usesageenabled=false;
			}
		
		//Checkpoint information
		var checkid=global.checkpoint[0];
		var checkroom=global.checkpoint[1];
		//Erase information if we've switched rooms
		if (checkroom!=room)
			{
				global.checkpoint[0]=noone;
				global.checkpoint[1]=noone;
			}
		//If we haven't erased information, we can move to the checkpoint
		if (checkid!=noone)
			{
				//This should never trigger but I'll do it anyway
				if (!instance_exists(checkid))
					{
						global.checkpoint[0]=noone;
						global.checkpoint[1]=noone;
					}
				else
					{
						Ed.x=checkid.x_check;
						Ed.y=checkid.y_check;
					}
			}
		
		//Dammit I've got to put this here
		var prevRoom=previous_room;
		with (global.currentinstance)
			{
				if (reversedir)
					directionfacing=-directionfacing;
				/*This is the "wake up" event, I've removed it
				if (room=room_EdSpace1_1)
					{
						//Discover your first event
						scr_todo_discover(0);
					}*/
				if (room==rm_Edbedroom)
					{
						scr_todo_complete(0);					//Wake up
						if (prevRoom==rm_EdSpace2_6)
							scr_todo_complete(23);				//Wake up part 2 
					}
				//Snap Ed to the floor if the floor is within 32 blocks
				scr_snap_to_floor();
			}
	}
if (createcam==true)
	{
		instance_create_layer(0,0,"Controllers",obj_camera);
		if camzoom=true
			{
				instance_create_layer(0,0,"Controllers",cam_zoom_controller);
			}
	}
if (createtransition=true)
	{
		scr_create_transition(TRANSITION.T_OUT);
	}
	
if (elevator==true)
	{
		global.softpause=true;
		with (obj_elevator_doors)
			{
				visible=true;
				image_index=image_number-1
				doorsclosed=true;
				doorsopening=true;
			}
	}
	
//Just check if the orb array needs updating
//Or don't because there's literally no need to do that because it checks whenever you collect an orb you dumb fucking idiot this was breaking the counter goddamn you
//scr_roomarray_check_orbs_completed();

//I'm actually including a script anyway incase - I might remove orbs in future or something, I dunno

#region adjusted script
var grid=global.roomarray;
var orbnum=instance_number(parent_orb);
var grid_height=ds_grid_height(grid);
if orbnum=0
	{
		//Find our room in the grid
		var i;
		for (i=0;i<grid_height;i+=1)
			{
				if ds_grid_get(grid,ROOMARRAY.ROOM,i)=room
					{
						ds_grid_set(grid,ROOMARRAY.ORBSFOUND,i,true);
					}
				//Let's also quickly chcek secrets are complete
				if ds_grid_get(grid,ROOMARRAY.SECRETSNUMBER,i)<=0
					{
						ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,true);
					}
				else
					{
						ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,false);
					}
			}
	}
else
	{
		//Find our room in the grid
		var i;
		for (i=0;i<grid_height;i+=1)
			{
				if ds_grid_get(grid,ROOMARRAY.ROOM,i)=room
					{
						ds_grid_set(grid,ROOMARRAY.ORBSFOUND,i,false);
					}
				//Let's also quickly chcek secrets are complete
				if ds_grid_get(grid,ROOMARRAY.SECRETSNUMBER,i)<=0
					{
						ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,true);
					}
				else
					{
						ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,false);
					}
			}
	}
#endregion

//We'll also set the room set we just loaded into as discovered, if it is not
var rm=room;
//Find the room in the grid
var i;
var discoverednum=0;
//Gate all this behind if its an allowed room set
if (scr_is_disallowed_room(rm)==false)
	{
		var hascheckeddiscovered=false;
		for (i=0;i<grid_height;i+=1)
			{
				if ds_grid_get(grid,ROOMARRAY.ROOM,i)=rm
					{
						#region check how many rooms from the set are discovered but only does it once
						if (hascheckeddiscovered==false)
							{
								hascheckeddiscovered=true;
								var set=ds_grid_get(grid,ROOMARRAY.ROOMSET,i);
								//Now do an additional loop to find the first room in the set and check if at least one is already discovered
								for (j=0; j<grid_height; j+=1)
									{
										if (ds_grid_get(grid,ROOMARRAY.ROOMSET,j)==set)
											{
												discoverednum+=ds_grid_get(grid,ROOMARRAY.DISCOVERED,j);
											}
									}
							}
						#endregion
						//Set as discovered
						ds_grid_set(grid,ROOMARRAY.DISCOVERED,i,true);
						break;
					}
			}
	
		//Now we know if discoverednum==0 then the room hasn't been discovered
		//We'll get the roomset name and pass it to a new obj called show roomset
		if (discoverednum==0 and global.attract==false)
			{
				var grid=global.roomsets;
				var gridheight=ds_grid_height(grid);
				var setname="Programmer machine broke.";
				//We know the set beause it's stored in set
				for (i=0; i<gridheight; i+=1)
					{
						if (ds_grid_get(grid,ROOMGROUPCONSTS.REF,i)==set)
							{
								setname=ds_grid_get(grid,ROOMGROUPCONSTS.NAME,i);
							}
					}
				var displayname=instance_create_layer(x,y,layer,obj_showroomset);
				displayname.text=setname;
			}
	}

global.loading=false;
//Not having this check bricked my save file lol
if (scr_is_disallowed_room(room)==false)
	{
		//Global.currentprofile=4 is reserved for level select
		if (!global.attract)
			{
				if (global.currentprofile<4)	{
					scr_save_game(global.currentprofile);
					instance_create_layer(0,0,layer,obj_floppy);
				}
			}
		else //attract mode recording
			{
				var attractobj=obj_attract_record;
				attractobj=obj_attract_playback; //Comment this out if you are recording a demo!
				instance_create_layer(0,0,"Controllers",attractobj);
			}
	}

global.canleavelevel=canleavelevel;

//Also map enhancer data!!
scr_mapenhancer_roomstart();