/// @description set alarm, turns on vairiables
// You can write your code in this editor

if (scr_is_disallowed_room(room)==true)
	{
		instance_destroy();
		exit;
	}

alarm[0]=300;
alpha=0;