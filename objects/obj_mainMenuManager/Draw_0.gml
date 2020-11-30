/// @description

draw_set_alpha(rectAlpha);
var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);

draw_set_colour(c_black);
draw_rectangle(camx,camy,camx+480,camy+270,false);

draw_set_alpha(1);