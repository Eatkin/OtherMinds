//Created 26/08/19
//Last updated 26/08/19

var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camw=camera_get_view_width(cam);
var camh=camera_get_view_height(cam);

var dist;
if (scr_on_camera()==true)
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
var _sx=argument0;
_sx=_sx*(1-min(1,dist/camw));

with (obj_camera)
	{
		shakex=max(shakex,_sx);
	}