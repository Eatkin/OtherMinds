//Created 21/09/19
//Last updated 21/09/19

//At the moment I just want to bitflip pause if start is pressed
//But also if there's a soft pause we're in a cutscene or dialogue or something
if global.softpause=1
	{
		exit;
	}
	
if (scr_is_disallowed_room(room)==true)
	{
		exit;
	}
	
if (global.inputs[15]=1 and !instance_exists(obj_pauseMenuManager) and !instance_exists(obj_newCredits) and !instance_exists(parent_cutscene))
	{
		if (global.attract==true)
			{
				scr_quit_to_menu();
				exit;
			}
		if (!instance_exists(obj_map_screen))
			{
				scr_set_vibration(0,0,0);
				global.inputs[15]=0; //Make sure we don't hit the pause trigger again in the pause object's step event
				instance_create_layer(x,y,layer,obj_map_screen);
			}
	}