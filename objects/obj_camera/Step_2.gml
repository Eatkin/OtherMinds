/// @description Follows the correct object
// You can write your code in this editor

/*Old script
var cam=view_camera[0]
var objfollowing=camera_get_view_target(cam);
if global.currentinstance!=objfollowing
	{
		camera_set_view_target(cam,global.currentinstance);
	}
	*/
	
//New script
scr_camera_step();