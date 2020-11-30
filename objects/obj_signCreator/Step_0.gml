/// @description

if (global.hardpause)
	exit;
	
if (activated)	{
	global.softpause=true;
	
	if (!eventIsComplete)	{
		//Flag event
		eventIsComplete=true;
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one, EVENTS_EDSPACE_ONE.SIGNCREATED);
		//Create sign
		var _sign=instance_create_layer(128,592,"Players",obj_sign_direction);
		_sign.image_index=11;
		_sign.dir=1;		//Facing up!
	
		//Follow the sign
		obj_camera.following=_sign;
	}
	
	//If the sign is on camera, count down the timer until it hits zero then return to Ed
	if (scr_on_camera(obj_camera.following))	{
		timer-=1;
		if (timer==0)	{
			obj_camera.following=noone;
			global.softpause=false;
			instance_destroy();
		}
	}
}