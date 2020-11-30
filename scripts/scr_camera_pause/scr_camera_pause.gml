//Created 14/08/19
//Last updated 14/08/19

//Cam variables
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);
/*var camhborder=camera_get_view_border_x(camera);
var camvborder=camera_get_view_border_y(camera);*/

var scalefactor=0.5;

//In this case we literally just zoom the camera then go back to normal
//Lerp the zoom
var newcamw=lerp(camwidth,thecamwidth*scalefactor,0.1);
var newcamh=lerp(camheight,thecamheight*scalefactor,0.1);
if abs(newcamw-thecamwidth*scalefactor)<1
	{
		newcamw=thecamwidth*scalefactor;
	}
if abs(newcamh-thecamheight*scalefactor)<1
	{
		newcamh=thecamheight*scalefactor;
	}
		
//Adjust camera
var newcamx=camx-(newcamw-camwidth)/2;
var newcamy=camy-(newcamh-camheight)/2;
camera_set_view_size(camera,newcamw,newcamh);
//Can't seem to get this right doh
/*
newcamx=lerp(newcamx,following.x-newcamw*0.5,0.1);
newcamy=lerp(newcamy,following.y-newcamh*0.5,0.1);*/
	
camera_set_view_pos(camera,newcamx,newcamy);