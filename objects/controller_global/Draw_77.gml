/// @description Sets shaders for application surface
// You can write your code in this editor

scr_set_pause_shader();

var xscale=window_get_width()/display_get_gui_width();
xscale=floor(xscale);
var yscale=window_get_height()/display_get_gui_height();
yscale=floor(yscale);
draw_surface_ext(application_surface,0,0,xscale,yscale,0,c_white,1);

shader_reset();