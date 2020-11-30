/// @description Movement
// You can write your code in this editor

event_inherited();

if (soundplaying==noone)
	{
		scr_play_sound(snd_bee_buzz,true,0);
	}

if state=PlayerState.idle
	{
		state=PlayerState.freeflying;
	}

scr_states_step();