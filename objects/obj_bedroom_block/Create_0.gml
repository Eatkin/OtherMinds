/// @description

// Inherit the parent event
event_inherited();

sprite_index=spr_block_black;
//Move the block if its already been pushed
if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.PUSHEDBEDROOMBLOCK)=true
	{
		x+=32;
		y+=32;
	}