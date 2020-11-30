/// @description Checks if off screen, whatever
// You can write your code in this editor

event_inherited();

scr_states_step();

//Explode outside arena
if x!=clamp(x,352,864)
	{
		scr_play_sound(sound_explode,0,0);
		instance_destroy();
	}