/// @description

if (!instance_exists(obj_transition))
	{
		instance_create_layer(x,y,layer,obj_edHouseCutsceneAfterDayOne);
		instance_destroy();
	}