/// @description Insert description here
// You can write your code in this editor

if global.hardpause=1
	{
		image_speed=0;
		scr_pause_alarms();
		exit;
	}
	
image_speed=1;

//Stop the animation after its finished
if image_index>image_number-1
	{
		image_speed=0;
	}