/// @description

// @description Draw marker when above level
// You can write your code in this editor

var guiwidth=display_get_gui_width();
var guiheight=display_get_gui_height()-global.helpbar*sprite_get_height(spr_HUD_box);

//Draw the iframes thing
if !surface_exists(hurtsurface)
	{
		hurtsurface=surface_create(guiwidth,guiheight);
	}
	
//Draw the surface
surface_set_target(hurtsurface);
draw_clear_alpha(0,0);
draw_set_color(c_red);
draw_set_alpha(alarm[0]/60);
draw_rectangle(0,0,guiwidth,guiheight,0);
draw_set_alpha(1);
gpu_set_blendmode(bm_subtract);
draw_ellipse(-guiwidth*0.18,-guiheight*0.18,guiwidth*1.18,guiheight*1.18,false);
gpu_set_blendmode(bm_normal);
surface_reset_target();


if global.brightness!=1
	{
		shader_set(shd_brightness);
		var b=shader_get_uniform(shd_brightness,"brightness");
		shader_set_uniform_f(b,global.brightness);
		var greyscale=shader_get_uniform(shd_brightness,"greyscale");
		shader_set_uniform_f(greyscale,0);
	}
draw_surface(hurtsurface,0,0);
if global.brightness!=1
	{
		shader_reset();
	}