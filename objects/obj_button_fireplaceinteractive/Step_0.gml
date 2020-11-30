/// @description Activate linked instance
// You can write your code in this editor

event_inherited();

if active=1
	{
		active=0
		linkedinstance.activated=1;
		scr_play_sound(sound_clickon,0,0);
	}