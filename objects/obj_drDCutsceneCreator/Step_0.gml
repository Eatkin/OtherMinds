/// @description

if (!instance_exists(obj_transition)  and !global.hardpause and parent_main_character.x<x)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_drDCutscene);
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.DRDCUTSCENE);
		instance_destroy();
	}