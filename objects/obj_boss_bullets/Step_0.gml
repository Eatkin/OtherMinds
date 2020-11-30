/// @description Movement
// You can write your code in this editor

event_inherited();

scr_states_step();

if x!=clamp(x,352,864)
	{
		scr_play_sound(sound_explode,0,0);
		instance_destroy();
	}