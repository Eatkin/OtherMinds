/// @description

if (!instance_exists(obj_transition)  and !global.hardpause and parent_main_character.x>x and parent_main_character.y>y)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_Ochre_blockCutscene);
		global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.BLOCKCUTSCENE);
		instance_destroy();
	}