/// @description

//Draw the arrow
//Except not if we are in a timetrial because we spawn one of these for the level transition lol
if (instance_exists(obj_timetrial))
	{
		exit;
	}
var dist=abs(parent_main_character.x-x);
var alpha=1;

alpha-=max(0,(dist-92)/128);
alpha=max(alpha,0);

var dir=sign(room_width*0.5-x);
var xdraw=x+16*dir;
if (dir==1)
	{
		xdraw+=sprite_width;
	}
var ydraw=max(y+sprite_height*0.5,y+sprite_height-32);

var arrowsprite=spr_arrow;
var width=sprite_get_width(arrowsprite);
var height=sprite_get_height(arrowsprite);

if (!surface_exists(arrowsurf))
	{
		arrowsurf=surface_create(width,height);
	}

surface_set_target(arrowsurf);
draw_clear_alpha(0,0);
var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);
draw_sprite_ext(spr_arrow,0,width*0.5,height*0.5,dir,1,0,c_white,1);
shader_reset();
surface_reset_target();

draw_set_alpha(alpha);
draw_surface(arrowsurf,xdraw-width*0.5, ydraw-height*0.5);
draw_set_alpha(1);