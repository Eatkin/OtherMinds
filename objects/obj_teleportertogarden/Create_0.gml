/// @description Destination variable (define in creation code)
// You can write your code in this editor

destination=id;
canteleport=false;
scr_teleport_map_check();

theplayer=noone;
thetransition=noone;

if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.ROCKTELEPORTACTIVE)==false)
	{
		instance_destroy();
	}