/// @description trigger event

global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO);
with (global.currentinstance)
	scr_todo_discover(17);