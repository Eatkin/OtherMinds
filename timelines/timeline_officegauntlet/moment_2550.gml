/// @description room lock-in

instance_destroy(inst_1CF51C0B);
var player=parent_main_character;

if (player.x>=3088)
	{
		scr_regionlock(3088,112,true);
	}

//Deactivate all now-unused pushables
with (parent_push)
	if (x<2736)
		instance_deactivate_object(id);