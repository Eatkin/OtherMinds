/// @description

var guiwidth=display_get_gui_width();
var guiheight=display_get_gui_height();

hurtsurface=surface_create(guiwidth,guiheight);

alarm[0]=60;

image_yscale=dsin(global.gravdirection);