/// @description set all relavant instance codes
// You can write your code in this editor

event_inherited();

if (activated)
	{
		if (room==room_EdSpace1_4)
			global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.EDSPACEFOUR_ROOMFOURCOMPLETE);
		with (obj_block_on)
			activated=true;
		with (obj_block_off)
			activated=activated^1; //Sometimes they will be activated but won't have changed because something's in the way
		
		activated=false;
	}