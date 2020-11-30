/// @description

//Play state must be idle or run to ensure they're on the ground

if (!instance_exists(obj_transition)  and !global.hardpause and parent_main_character.x>x and (parent_main_character.state==PlayerState.idle or parent_main_character.state==PlayerState.running))
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_endCutscene);
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.ENDCUTSCENE);
		instance_destroy();
	}