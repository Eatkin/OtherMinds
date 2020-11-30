/// @description Set speed
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if  global.hardpause=1
	{
		image_speed=0;
		scr_pause_alarms();
		exit;
	}
	
if alarm[0]=-1
	{
		image_speed=1;
	}
	
if image_index>image_number-0.5
	{
		instance_destroy();
	}