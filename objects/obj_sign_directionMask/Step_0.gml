/// @description Spins
// You can write your code in this editor

event_inherited();

//exit if paused
if global.hardpause=1
	{
		exit;
	}

//This is literally all we need
image_index=owner.image_index;

scr_states_step();