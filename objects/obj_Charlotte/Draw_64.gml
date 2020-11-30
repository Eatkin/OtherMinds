// @description Draw marker when above level
// You can write your code in this editor

if global.currentinstance!=id
	{
		exit;
	}

var camera=view_camera[0];
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);

var maxwidth=obj_camera.thecamwidth;
var zoom=maxwidth/camwidth;

if y=clamp(y,camy,camy+camheight)
	{
		exit;
	}

//Set market coords relative to GUI
var markerx=x-camx;
var markery=0+sprite_get_height(spr_marker)*0.5;
//Didn't think I'd need this but sometimes you drop below screen on the zoomed levels
//(so we don't show a marker for that)
if y>camy+camheight
	{
		exit;
	}

//Adjust for zoom
//Okay problem is here we get to the screen edge and this gives a fixed adjustment
if zoom!=1
	{
		markerx+=maxwidth*0.5*(1-1/zoom);
		markerx=min(markerx,2*(x-camx));
	}

scr_set_pause_shader();
draw_sprite(spr_marker,marker_index,markerx,markery);
shader_reset();