/// @description

if (!instance_exists(obj_transition) and !global.hardpause)
	{
		//Depends where we are, if we haven't viewed the firts cutscene it createes that
		//If we have and we're also returning to EdSpace, create that
		//Otherwise just destroy
		if (!scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE) and scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE))	{
			//create return home from menu dialogue
			instance_create_layer(0,0,layer,obj_EdSpace1_1GoHomeCutscene);
			global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.RETURNHOMEDIALOGUE);
		}
		else if (!scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.FIRSTCUTSCENE))	{
			//Create the wake up dialogue
			instance_create_layer(0,0,layer,obj_EdSpace1_1WakeUpCutscene);
			global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.FIRSTCUTSCENE);
		}
		instance_destroy();
	}