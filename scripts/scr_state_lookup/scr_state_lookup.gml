//Created 05/10/19
//Last updated 05/10/19

//Priority - jump -> moving -> duck

var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var camstate=obj_camera.state;

var gravMultiplier=dsin(global.gravdirection);

if (!canmove)
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
	}

if (jumpinput and jumpenabled)
	{
		scr_jump();
		if camstate!=CAMERA_MODE.CAM_FIXED
			obj_camera.state=CAMERA_MODE.CAM_FOLLOW;
		exit;
	}

if (gravityenabled)
	if (scr_inaircheck())
		{
			if camstate!=CAMERA_MODE.CAM_FIXED
				obj_camera.state=CAMERA_MODE.CAM_FOLLOW;
			exit;
		}
	
//Set the sprite index
if (sprite_index!=sprite_lookup)
	{
		sprite_index=sprite_lookup;
		image_index=0;
	}

var upheld=sign(vinput)*gravMultiplier;
if (upheld)
	{
		if (image_index>image_number-1)
			image_speed=0;
		else
			image_speed=1;
	}
else
	{
		//This is basically an arbitrary value to stop the animation 'snapping' back to idle
		if (image_index<0.5)
			{
				state=PlayerState.idle;
				if (camstate!=CAMERA_MODE.CAM_FIXED)
					obj_camera.state=CAMERA_MODE.CAM_FOLLOW;
				exit;
			}
		else
			image_speed=-1;
	}
	
	
//This changes the camera state to scroll up
if (timeinstate>20 and camstate!=CAMERA_MODE.CAM_FIXED)
	{
		if (gravMultiplier==1)
			obj_camera.state=CAMERA_MODE.CAM_SCROLLUP;
		else
			obj_camera.state=CAMERA_MODE.CAM_SCROLLDOWN;
	}	