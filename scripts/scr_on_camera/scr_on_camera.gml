//Created 16/08/19
//Last updated 16/08/19

//Returns true if object is on camera

//Optional argument to check if a different object is on camera
var b_left=bbox_left;
var b_right=bbox_right;
var b_top=bbox_top;
var b_bottom=bbox_bottom;
if (argument_count>0)
	{
		var camcheckobj=argument[0];
		var b_left=camcheckobj.bbox_left;
		var b_right=camcheckobj.bbox_right;
		var b_top=camcheckobj.bbox_top;
		var b_bottom=camcheckobj.bbox_bottom;
	}
var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camw=camera_get_view_width(cam);
var camh=camera_get_view_height(cam);

var xoncamera=(b_left==clamp(b_left,camx,camx+camw) or b_right==clamp(b_right,camx,camx+camw)) ? true : false;
var yoncamera=(b_top==clamp(b_top,camy,camy+camh) or b_bottom==clamp(b_bottom,camy,camy+camh)) ? true : false;

if(xoncamera and yoncamera)
	{
		return true;
	}
return false;