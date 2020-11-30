/// @description

if (place_meeting(x,y,parent_main_character))	
	{
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.BLOCKSEXPLODE);
		instance_destroy();
	}