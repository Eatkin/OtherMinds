directionfacing=-1;

if (!scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.OCHREHILLCOMPLETE))
	instance_destroy();

/*No need
if (scr_isDark())
	instance_destroy();*/