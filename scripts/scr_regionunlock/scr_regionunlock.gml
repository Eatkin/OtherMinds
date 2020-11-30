//Created 26/08/19
//Last updated 26/08/19

//This can be called from boss controller
//It'll set new variables for the blocks locking the player in the region
//It only needs calling once
//It also only locks in the h movement
//That can be an optional parameter later if I feel like I need it

//estroy blocks
if instance_exists(block[0])
	{
		with (block[0])
			instance_destroy();
		with (block[1])
			instance_destroy();
	}
else
	exit;

//Automatically set the camera mode
with (obj_camera)
	if (state==CAMERA_MODE.CAM_FIXED)
		state=CAMERA_MODE.CAM_FOLLOW;