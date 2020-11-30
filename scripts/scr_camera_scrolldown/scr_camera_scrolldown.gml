//Create 14/07/19
//Last updated 15/08/19

//Cam variables
var HUD_height=sprite_get_height(spr_HUD_box)*global.helpbar;
//var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera)-HUD_height;
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);
//This is the only change really, we cut the border way down to be able to scroll past it
var camvborder=camera_get_view_border_y(camera)*.5;


//Player variables
var player=global.currentinstance;
var playery=player.y;

//Okay so all we need to do is move the camera down until it hits camy=playery-vborder

var newcamy=camy;

if camy<playery-camvborder
	{
		newcamy+=1;
	}
if newcamy+camheight>room_height
	{
		newcamy=room_height-camheight;
	}

var dy=player.y-player.yprevious;
newcamy+=dy;
var dx=player.x-player.xprevious;
camx+=dx;

//Now make adjustments to make sure it doesn't exceed the boundary
camx=scr_clamp_camera_x(camx);
newcamy=scr_clamp_camera_y(newcamy);
	
camera_set_view_pos(camera,camx,newcamy);