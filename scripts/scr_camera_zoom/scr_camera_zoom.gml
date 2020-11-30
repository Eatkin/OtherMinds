//Created 14/08/19
//Last updated 14/08/19

//Cam variables
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);
/*var camhborder=camera_get_view_border_x(camera);
var camvborder=camera_get_view_border_y(camera);*/

var scalefactor=argument0;

//We have two variables called thecamwidth and thecamheight which are our initial values
//We want to go to maybe .75* those values
//The centre of the cam should focus exactly on our target

//If the instance we're following gets deleted, default to the player
if (!instance_exists(following) and following!=noone)
	{
		following=global.currentinstance;
	}

if (following==noone)
	{
		//Adjust cam height cause HUD is turned back on
		//Okay this seems like a good idea, but it's really not
		//var HUD_height=sprite_get_height(spr_HUD_box)*global.helpbar;
		//Here we zoom out and go back to cam mode follow when zoomed out
		var player=global.currentinstance;
		//Lerp the zoom
		var newcamw=lerp(camwidth,thecamwidth,0.1);
		var newcamh=lerp(camheight,thecamheight,0.1);
		if abs(camwidth-thecamwidth)<1
			{
				newcamw=thecamwidth;
			}
		if abs(camheight-thecamheight)<1
			{
				newcamh=thecamheight;
			}
		if (newcamw==thecamwidth and newcamh==thecamheight)
			{
				state=CAMERA_MODE.CAM_FOLLOW;
			}
		var newcamx=camx+(camwidth-newcamw)/2;
		var newcamy=camy+(camheight-newcamh)/2;
		camera_set_view_size(camera,newcamw,newcamh);
		newcamx=lerp(newcamx,player.x-newcamw*0.5,0.1);
		newcamy=lerp(newcamy,player.y-newcamh*0.5,0.1);
	}
else
	{
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
		newcamx=lerp(newcamx,following.x-newcamw*0.5,0.1);
		newcamy=lerp(newcamy,following.y-newcamh*0.5,0.1);
	}
	

//As we're not using xspeed or yspeed set them to zero, they are conserved otherwise!!!
xspeed=0;
yspeed=0;

//Now make adjustments to make sure it doesn't exceed the boundary and set position
newcamx=scr_clamp_camera_x(newcamx);
if following=global.currentinstance and !instance_exists(obj_transition)
	{
		newcamy=scr_clamp_camera_y(newcamy);
	}
else
	{
		//This is manually calculated instead of the script because the HUD box disappears
		newcamy=clamp(newcamy,0,room_height-camheight);
	}
camera_set_view_pos(camera,newcamx,newcamy);