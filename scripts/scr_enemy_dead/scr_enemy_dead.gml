//Created 08/08/19
//Last updated 08/08/19

//Move enemy really far away and make invisible
if visible=1
	{
		visible=0;
		x=-1000;
		y=-1000;
	}

//This sets the enemy to respawn when it's 1.5 screen width's away from player in both directions
var player=instance_nearest(xstart,ystart,parent_main_character);
var camx=camera_get_view_x(view_camera[0]);
var camy=camera_get_view_y(view_camera[0]);
var camw=camera_get_view_width(view_camera[0]);
var camh=camera_get_view_height(view_camera[0]);
var dist=sqrt(sqr(camw/2)+sqr(camh/2))*1.2;
if point_distance(xstart,ystart,player.x,player.y)>=dist and point_distance(xstart,ystart,camx+camw*0.5,camy+camh*0.5)>=dist
	{
		x=xstart;
		y=ystart;
		visible=1;
		hp=hpmax;
		state=PlayerState.idle;
	}