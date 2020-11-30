/// @description

if (!instance_exists(obj_transition)  and !global.hardpause)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_EdSpace1_secretCutscene);		//typo in obj name lol
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.SECRETCUTSCENE);
		instance_destroy();
	}