/// @description

event_inherited();


var triggeredCutscene=false;
if active=true
	{	//This is the first time we get here
		triggeredCutscene=true;
		if (!scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSONE))
			{
				global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.PASSONE);
				cutscene[0]=true;
				scr_play_sound(snd_menu_confirm,0,0);
				global.softpause=true;
			}
		//For this, must have completed edspace two
		else if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE) and !scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE))
			{
				global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE);
				cutscene[1]=true;
				scr_play_sound(snd_menu_confirm,0,0);
				global.softpause=true;
			}
		else
			{
				triggeredCutscene=false;
				scr_play_sound(snd_menu_no,0,0);
			}
		active=false;
	}

//One-time actions (i.e. softpause + spawn sage)
if (triggeredCutscene)
	{		
		with (obj_Ed)
			{
				scr_spawn_Sage();
				global.currentinstance=id;
			}
		global.softpause=true;
	}

//Cutscene specific actions
if (cutscene[0])
	{
		outlineshader=false;
		//Turn off outline
		with (parent_main_character)
			outlineshader=false;
		var _dir=obj_Ed.directionfacing;
		global.softpause=true;
		var _queued=dialoguequeued
		with (obj_sage)
			{
				if (abs(x-xstart)<24)
					{
						s_hinput=0.4*_dir;
						s_vinput=0.2;
					}
			}
		if _queued=false
			{
				scr_queue_dialogue_box(scr_return_text(282));
				scr_queue_dialogue_box(scr_return_text(283));
				scr_queue_dialogue_box(scr_return_text(284));
				scr_queue_dialogue_box(scr_return_text(285));
				scr_queue_dialogue_box(scr_return_text(286));
				_queued=true;
				with (obj_camera)
					{
						following=global.currentinstance;
					}
			}
		dialoguequeued=_queued;
		timer+=1;
		if (ds_queue_empty(global.dialoguequeue) and dialoguequeued)
			{
				with (obj_sage)
					s_b_three=true;
					
				cutscene[0]=false;
				global.softpause=false;
				with (global.currentinstance)
					{
						scr_todo_discover(6);
						scr_todo_discover(7);
						scr_todo_discover(8);
						scr_todo_discover(9);
					}
			}
	}
else if (cutscene[1])
	{
		outlineshader=false;
		//Turn off outline
		with (parent_main_character)
			outlineshader=false;
		var _dir=obj_Ed.directionfacing;
		global.softpause=true;
		var _queued=dialoguequeued;
		with (obj_sage)
			{
				if (abs(x-xstart)<24)
					{
						s_hinput=0.4*_dir;
						s_vinput=0.2;
					}
			}
		if (!_queued)
			{
				scr_queue_dialogue_box(scr_return_text(669));
				scr_queue_dialogue_box(scr_return_text(670));

				_queued=true;
				
				with (obj_camera)
					following=global.currentinstance;
			}
			
		dialoguequeued=_queued;
		timer+=1;
		
		if (ds_queue_empty(global.dialoguequeue) and dialoguequeued)
			{
				//Re-enter Ed
				with (obj_sage)
					s_b_three=true;
					
				cutscene[1]=false;
				global.softpause=false;
				
				with (global.currentinstance)
					scr_todo_discover(22);

			}
	}