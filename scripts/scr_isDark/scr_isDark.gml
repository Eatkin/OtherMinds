//Created 09/06/20

//Conditions to say whether it's dark or not
//Basically we have to cycle through all the flags in order switching darkness on and off depending where we are in the game

var isDark=false;
//Completed all our events from day one
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO))
	isDark=true;
	
//Just beaten EdSpace two
if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
	isDark=false;
	
return isDark;