/// @description

if (!instance_exists(obj_transition)  and !global.hardpause and parent_main_character.x>864)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_EdSpace1_bossCutscene);
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSCUTSCENE);
		instance_destroy();
	}