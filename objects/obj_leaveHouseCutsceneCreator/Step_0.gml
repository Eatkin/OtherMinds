/// @description

if (!instance_exists(obj_transition)  and !global.hardpause)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_leaveHouseCutscene);
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.LEAVEHOUSECUTSCENE);
		instance_destroy();
	}