/// @description

// Inherit the parent event
event_inherited();

if (active==true)
	{
		if (instance_exists(obj_collapsing_floor))
			with (obj_collapsing_floor)
					activated=true;
		scr_play_sound(snd_buttonpress,false,0);
		active=false;
	}