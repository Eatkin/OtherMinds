/// @description

var player=parent_main_character;
if (player.x>x)	{
	scr_roomarray_set_secret_completed();
	global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.MYSTERIOUSROOMSECRET);
	instance_destroy();
}