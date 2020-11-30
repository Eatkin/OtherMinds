/// @description

//Cancel the cutscene creation if you press a button
//It has no "active" variable so use imag_index because spaghettittjigreitititiititttiiitittit
if (instance_exists(obj_button_on_off) and obj_button_on_off.image_index==1)	{
	global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.ILLHANDLETHIS);
	instance_destroy();
}

if (parent_main_character.x>550 and !global.hardpause)
	{
		instance_create_layer(0,0,layer,obj_EdSpace1_2SageCutscene);
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.ILLHANDLETHIS);
		instance_destroy();
	}