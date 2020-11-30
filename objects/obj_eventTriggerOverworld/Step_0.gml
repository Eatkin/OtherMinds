/// @description

if (!place_meeting(x,y,obj_crackedblock))	
	{
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.OFFICEBLOCKSBROKEN);
		instance_destroy();
	}