/// @description Movement
// You can write your code in this editor

event_inherited();

if state=PlayerState.idle
	{
		state=PlayerState.freeflying;
	}

scr_states_step();