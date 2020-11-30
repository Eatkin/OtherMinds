/// @description

// Inherit the parent event
event_inherited();

label=scr_return_text(563);

if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.MEMO_COLLECTED)==true)
	{
		instance_create_layer(x,y,layer,obj_floorCollapseButton);
		instance_destroy();
	}