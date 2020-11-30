/// @description

var playeronfloor=false;

with (parent_main_character)
	if (place_meeting(x,y+1,obj_solid))
		playeronfloor=true;

if (playeronfloor and !global.hardpause and ds_queue_empty(global.dialoguequeue))
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_Ochre_catsCutscene);
		instance_destroy();
	}