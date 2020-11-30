// @description Draw marker when above level
// You can write your code in this editor

if (!global.softpause or global.currentinstance==id)
	exit;

var camera=view_camera[0];
var camwidth=camera_get_view_width(camera);
var camheight=camera_get_view_height(camera);
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);

var maxwidth=obj_camera.thecamwidth;
var zoom=maxwidth/camwidth;

if (y==clamp(y,camy,camy+camheight) and x==clamp(x,camx,camx+camwidth))
	exit;

//Set market coords relative to GUI
var markerx=x;
var markery=y;

markerx=clamp(markerx,camx,camx+camwidth);
markery=clamp(markery,camy,camy+camheight);
//Didn't think I'd need this but sometimes you drop below screen on the zoomed levels
//(so we don't show a marker for that)
var _exit=false;
var gravMultiplier=(global.gravdirection==90)	?	1 : -1;
if (y>camy+camheight and gravMultiplier==1)
	_exit=true;
if (y<0 and gravMultiplier==-1)
	_exit=true;

/*Why the fuck is this here?
if (gravMultiplier==-1)
	markery+=room_height-sprite_get_height(spr_marker);*/
	
//Adjust for zoom
//Okay problem is here we get to the screen edge and this gives a fixed adjustment
/*Was I an idiot when I wrote all this absolute nonsense?
if zoom!=1
	{
		markerx+=maxwidth*0.5*(1-1/zoom);
		markerx=min(markerx,2*(x-camx));
	}*/

scr_set_pause_shader();
draw_sprite(spr_marker,marker_index,markerx,markery);
shader_reset();