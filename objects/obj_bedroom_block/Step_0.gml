/// @description

// Inherit the parent event
event_inherited();

if y>ystart and scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.PUSHEDBEDROOMBLOCK)=false
	{
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.PUSHEDBEDROOMBLOCK);
		scr_roomarray_set_secret_completed();
	}