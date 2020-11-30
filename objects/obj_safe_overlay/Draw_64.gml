/// @description

//Make sure the surface exists and draw the sprite on it
if !surface_exists(numberssurface)
	{
		numberssurface=surface_create(surf_width,surf_height);
		surface_set_target(numberssurface)
			{
				draw_sprite(numberssprite,0,0,0);
			}
		surface_reset_target();
	}
	
//Draw background
var spr=spr_safe_background;
var _x=(guiwidth-sprite_get_width(spr))*0.5;
var _y=(guiheight-sprite_get_height(spr))*0.5;
draw_set_alpha(backgroundalpha);
draw_sprite(spr,0,_x,_y);
draw_set_alpha(1);

//Draw tumblers
for (var i=0; i<4; i+=1)
	{
		var _x=(guiwidth/5)*(i+1)-9;
		var _y=tumblerydraw[i];
		if tumblerselected=i
			{
				draw_sprite(spr_safeupanddown,0,_x+1,_y);
			}
		draw_sprite(spr_safetumblerbackground,0,_x,_y);
		draw_surface_part(numberssurface,0,surfy[i],10,16,_x+4,_y+1);
	}