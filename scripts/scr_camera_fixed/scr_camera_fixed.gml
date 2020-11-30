//Created 20/08/19
//Last updated 20/08/19

var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);

if ylocked=false
	{
		var player=global.currentinstance;
		var ytarget=min(player.y-player.sprite_height,yfix);
	}
else
	{
		var ytarget=yfix;
	}
//Wow what a totally easy script
var camxnew=lerp(camx,xfix,0.5);
var camynew=lerp(camy,ytarget,0.5);

//Stop the lerping infinitely
if abs(camxnew-xfix)<1
	{
		camxnew=xfix;
	}
if abs(camynew-ytarget)<1
	{
		camynew=ytarget;
	}
				
//Now make adjustments to make sure it doesn't exceed the boundary
//This clamp script accounts for HUD at the bottom so should be all good
camxnew=scr_clamp_camera_x(camxnew);
camynew=scr_clamp_camera_y(camynew);
				
camera_set_view_pos(camera,camxnew,camynew);