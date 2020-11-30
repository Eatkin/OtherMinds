/// @description

if (!instance_exists(obj_transition)  and !global.hardpause)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_Ochre_FrankieCutscene);
		global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.FRANKIECUTSCENE);
		instance_destroy();
	}