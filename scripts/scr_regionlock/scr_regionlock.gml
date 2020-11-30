//Created 20/08/19
//Last updated 20/08/19

//This can be called from boss controller
//It'll set new variables for the blocks locking the player in the region
//It only needs calling once
//It also only locks in the h movement
//That can be an optional parameter later if I feel like I need it

var guiwidth=display_get_gui_width();
var xlock=argument0;
var ylock=argument1;
var ymove=argument2; //Whether to allow y to move
var blockwidth=sprite_get_width(spr_block);

//Create and resize blocks
block[0]=instance_create_layer(xlock-blockwidth,0,"blocks",obj_block);
block[1]=instance_create_layer(xlock+guiwidth,0,"blocks",obj_block);

var i;
for (i=0;i<2;i+=1)
	{
		scr_object_resize(block[i],blockwidth,room_height);
	}

//Automatically set the camera mode
with (obj_camera)
	{
		state=CAMERA_MODE.CAM_FIXED;
		xfix=xlock;
		yfix=ylock;
		ylocked=ymove^1;
	}