//Created 26/08/19
//Last updated 26/08/19

var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camw=camera_get_view_width(cam);
var camh=camera_get_view_height(cam);

var dist;
if scr_on_camera()=true
	{
		dist=0;
	}
else
	{
		var xdist=min(abs(x-camx-camw),abs(camx-x));
		var ydist=min(abs(y-camy-camh),abs(camy-y));
		dist=sqrt(sqr(xdist)+sqr(ydist));
	}

//Decay the shake ammount based on distance
var _sy=argument0;
_sy=_sy*(1-min(1,dist/camw));

with (obj_camera)
	{
		shakey=max(shakey,_sy);
	}