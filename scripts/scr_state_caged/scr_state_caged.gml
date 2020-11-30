//Created 13/02/20
//Last updated 13/02/20

moveenabled=false;
xscaleflipenabled=false;

sprite_index=sprite_caged;

if (instance_exists(obj_petsim))
	{
		instance_destroy(obj_petsim);
	}
if (instance_exists(obj_petfrankie))
	{
		instance_destroy(obj_petfrankie);
	}

var player=instance_place(x,y-1,parent_main_character);
if (player==noone)
	{
		exit;
	}
if (player.state==PlayerState.air and player.yspeed>0)
	{
		iframes=30;
		instance_create_layer(x,y,layer,obj_smoke);
		scr_play_sound(snd_jumponenemy,0,0);
		scr_set_vibration(1,1,10);
		player.yspeed=player.jumpheight;
		state=PlayerState.idle;
		moveenabled=true;
		xscaleflipenabled=true;
		if (object_index==obj_Sim)
			{
				instance_create_layer(x,y,layer,obj_petsim);
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDSAM);
			}
		if (object_index==obj_Frankie)
			{
				instance_create_layer(x,y,layer,obj_petfrankie);
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDFRANKIE);
			}
		
		//Complete the 'rescue cats' to do event
		if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDSAM)==true and scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.RESCUEDFRANKIE)==true)
			{
				//Set the global event because I probably will need that in future maybe, or maybe I won't lol who cares
				global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.RESCUEDCATS);
				with (global.currentinstance)
					{
						scr_todo_complete(6);
						scr_todo_discover(12);
					}
					
				//Also cutscene
				instance_create_layer(0,0,layer,obj_Ochre_CatsCutsceneCreator);
			}
		exit;
	}