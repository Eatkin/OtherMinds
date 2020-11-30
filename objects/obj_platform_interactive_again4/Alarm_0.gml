/// @description Move activation up a level
// You can write your code in this editor

activated=2;
global.softpause=0;
with (obj_camera)
	{
		following=noone;
		//Update events
		global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.INTERACTIVEPLATFORM_4);
	}