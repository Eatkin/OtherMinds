//Created 14/07/19
//Last updated 15/08/19

//Cam variables
var HUD_height=sprite_get_height(spr_HUD_box)*global.helpbar;
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera)-HUD_height;
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);
var camhborder=camera_get_view_border_x(camera);
var camvborder=camera_get_view_border_y(camera);

var zoom=thecamwidth/camwidth;
camhborder=camhborder/zoom;
camvborder=camvborder/zoom;



//Player variables
//This lets us override following the player
if (following==noone)
	var player=global.currentinstance;
else
	{
		//The HUD is invisible when following an event so we need to change this
		HUD_height=sprite_get_height(spr_HUD_box);
		var player=following;
	}
var playerx=player.x;
var playery=player.y;
//Okay this was all stupid
var distancefromxedge, distancefromyedge
var maxxspeed=player.maxxspeed*3;
var maxyspeed=player.maxyspeed*3;
var dir;
//Normalise the speedz
//This actually reduces it by such a hefty factor its only used for events
if following!=noone
	{
		var norm=sqrt(sqr(maxxspeed)+sqr(maxyspeed));
		maxxspeed=maxxspeed/norm;
		maxyspeed=maxyspeed/norm;
	}

maxxspeed=max(maxxspeed,10);
maxyspeed=max(maxyspeed,10);
				
//Alright I hope this works nicely
//We set the xspeed as a function of how close to the edge of the screen we are
//Also account for player's speed to adjust camera so you can see further infront if running or whatever
var pxspeed=(player.x-player.xprevious);
var pyspeed=(player.y-player.yprevious);
var factor=2;
if (object_is_ancestor(player,parent_possessable))
	if (player.x==player.xsafe and player.y==player.ysafe)	{
		pxspeed=0;
		pyspeed=0;
	}

playerx+=pxspeed*factor;
playery+=pyspeed*factor;

distancefromxedge=ceil(min(playerx-camx,camx+camwidth-playerx));
if distancefromxedge=ceil(playerx-camx)
	{
		dir=-1;
	}
else
	{
		dir=1;
	}
if distancefromxedge<camhborder
	{
		xspeed=maxxspeed*dir*(1-distancefromxedge/camhborder);
	}
if abs(xspeed)<=1
	{
		xspeed=0;
	}
//Finally if object is outside the range of camera
/*if sign(distancefromxedge)=-1
	{
		xspeed=maxxspeed*dir;
	}*/
					
distancefromyedge=ceil(min(playery-camy,camy+camheight-playery));
if distancefromyedge=ceil(playery-camy)
	{
		dir=-1;
	}
else
	{
		dir=1;
	}
if distancefromyedge<camvborder
	{
		yspeed=maxyspeed*dir*(1-distancefromyedge/camvborder);
	}
else
	{
		yspeed=0;
	}
	
//Finally if object is outside the range of camera
/*if sign(distancefromyedge)=-1
	{
		yspeed=maxyspeed*dir;
	}*/
					
//Set the position
//Okay this causes an earthquake near the edge of the room
//I think I need to do one position setting per step
var camxnew=camx+xspeed;
var camynew=camy+yspeed;


//Now make adjustments to make sure it doesn't exceed the boundary

camxnew=scr_clamp_camera_x(camxnew);
camynew=scr_clamp_camera_y(camynew);

			
camera_set_view_pos(camera,camxnew,camynew);