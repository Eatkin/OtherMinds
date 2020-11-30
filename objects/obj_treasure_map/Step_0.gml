/// @description Movement and bouncing
// You can write your code in this editor

//collide with a main character
//This must go above the inherited event or its doesn't work
if place_meeting(x,y,parent_main_character)
	{
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.COLLECTEDTREASUREMAP);
		with (global.currentinstance)
			{
				scr_todo_complete(5);
			}
	}

event_inherited();

if global.hardpause=1
	{
		exit;
	}