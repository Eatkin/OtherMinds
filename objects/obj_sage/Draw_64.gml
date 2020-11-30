/// @description Draw marker to show where Ed is
// You can write your code in this editor

var camera=view_camera[0];
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);
var x1=camx;
var x2=camx+camwidth;
var y1=camy;
var y2=camy+camheight;
var maxwidth=obj_camera.thecamwidth;
var zoom=maxwidth/camwidth;


if (scr_on_camera(parent_main_character)==true or global.softpause==true)
	{
		exit;
	}

var markerx;
var markery;
//This is half the sprite width
var markersize=sprite_get_width(spr_marker)/(2*zoom);

//Find Ed
var Ed=parent_main_character;
var Edx=Ed.x;
var Edy=Ed.y;
markerx=Edx;
markery=Edy;

markerx=clamp(markerx,x1+markersize,x2-markersize);
markery=clamp(markery,y1+markersize,y2-markersize-obj_HUD.hudheight*global.helpbar/zoom);
markerx-=camx;
markery-=camy;

markerx=markerx*zoom;
markery=markery*zoom;

scr_set_pause_shader();
draw_sprite(spr_marker,marker_index,markerx,markery);
shader_reset();