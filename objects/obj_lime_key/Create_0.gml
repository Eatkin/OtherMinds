/// @description

// Inherit the parent event
event_inherited();

if scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.COLLECTEDLIMEKEY)=true
	{
		instance_destroy();
	}