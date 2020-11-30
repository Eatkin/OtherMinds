/// @description

//We do not inherit the event because we need some adjustments doing

if active=1
	{
		if (global.maincharacter==obj_Charlotte)
			{
				scr_queue_dialogue_box(scr_return_text(474));
				obj_dialogue.x=x;
				obj_dialogue.y=y;
				active=false;
				exit;
			}
		
		#region check if we can leave yet
		//So we want to work backwards here to find what part of the game we're on
		//We save the 'passes' and check that when we have completed an 'edspace' or associated level, we have also collected the calander events
		var canLeave=true;
		//Here's a long list of conditions that mean we can leave
		//We've finished EdSpace 1 but haven't got our first events
		if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE) and !scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSONE))
			canLeave=false;
		//We've finished EdSpace 2 but not collected our second events
		if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE) and !scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE))
			canLeave=false;
			
		if (!canLeave)
			{
				active=0;
				scr_queue_dialogue_box(scr_return_text(326));
				obj_dialogue.x=x;
				obj_dialogue.y=y;
				exit;
			}
		#endregion
		
		global.softpause=1;
		if transitionobj=noone
			{
				scr_set_vibration(1,1,10);
				scr_play_sound(snd_door_open,false,0);
				transitionobj=scr_create_transition(TRANSITION.T_IN);
			}
		else
			{
				if !instance_exists(transitionobj) or transitionobj.transitioncomplete=true
					{
						global.softpause=0;
						//DEFAULT SETTING AS I DON'T HAVE A ROOM TO GO TO
						if destination=noone
							{
								room_restart();
								exit;
							}
						//REMOVE THIS LATER^ or don't because it'll never be triggered
						global.localdeaths=-1;
						room_goto(destination);
					}
			}
	}