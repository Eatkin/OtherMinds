//Created 18/07/19
//Last updated 18/07/19

//Various exceptions - map isn't open, not in a cutscene, not soft paused, not a disallowed room
if (global.inputs[14]=1 and !instance_exists(obj_map_screen) and !instance_exists(parent_cutscene) and !instance_exists(obj_newCredits))	{
	if (global.softpause or scr_is_disallowed_room(room))
		exit;
	if (global.attract)	{
		scr_quit_to_menu();
		exit;
	}
	if (!instance_exists(obj_pauseMenuManager))	{
		scr_set_vibration(0,0,0);
		global.inputs[14]=0; //Make sure we don't hit the pause trigger again in the pause object's step event
		instance_create_layer(x,y,layer,obj_pauseMenuManager);
	}
}