sprite_index=spr_ochrecrackedblock;
if (scr_event_check_complete(global.overworld_events,OVERWORLD_EVENTS.OFFICEBLOCKSBROKEN)==true)
	{
		instance_destroy();
	}