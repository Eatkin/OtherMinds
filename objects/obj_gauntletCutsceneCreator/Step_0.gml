/// @description

if (!instance_exists(obj_transition) and !global.hardpause)
	{
		instance_create_layer(x,y,layer,obj_gauntletEndCutscene);
		instance_destroy();
	}