/// @description

activated=false;
eventIsComplete=false;

//Timer for viewing the sign
timer=60;

if (scr_event_check_complete(global.edspaceevents_one, EVENTS_EDSPACE_ONE.SIGNCREATED))	{
	var _sign=instance_create_layer(128,592,"Players",obj_sign_direction);
	_sign.image_index=11;
	_sign.dir=1;		//Facing up!
	instance_destroy();
}