/// @description

/*
if global.currentinstance!=id
	{
		exit;
	}*/

var camera=view_camera[0];
//var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);

if y=clamp(y,camy,camy+camheight)
	{
		exit;
	}

//Set market coords relative to GUI
var markerx=x-camx;
var markery=0+sprite_get_height(spr_marker)*0.5+camheight*(y>camy+camheight);

scr_set_pause_shader();
draw_sprite(spr_markeralt,marker_index,markerx,markery);
shader_reset();