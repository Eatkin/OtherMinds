/// @description Movement and bouncing
// You can write your code in this editor

//collide with a main character
//This must go above the inherited event or its doesn't work
if place_meeting(x,y,parent_main_character)
	{
		global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.COLLECTEDLIMEKEY);
		//Think it gets destroyed in the 'obj_collect' script
		//instance_destroy();
	}

event_inherited();