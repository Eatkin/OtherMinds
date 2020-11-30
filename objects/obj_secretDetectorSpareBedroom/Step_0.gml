/// @description

if (place_meeting(x,y,obj_sid))	
	{
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.SPAREBEDROOMSECRET);
		scr_roomarray_set_secret_completed();
		instance_destroy();
	}