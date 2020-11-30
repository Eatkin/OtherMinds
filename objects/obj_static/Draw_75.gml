/// @description

var guiwidth=display_get_gui_width();
var guiheight=display_get_gui_height();

shader_set(shd_noise);
var _t=shader_get_uniform(shd_noise,"time");
shader_set_uniform_f(_t,random(1));
draw_rectangle(0,0,guiwidth,guiheight,false);
shader_reset();