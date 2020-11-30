/// @description Move activation up a level
// You can write your code in this editor

activated=2;
global.softpause=0;
with (obj_camera)
	{
		following=noone;
		//Update events
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.EDSPACEFOUR_PLATFORMONE);
	}