/// @description

if (global.rng==1)
	{
		scr_set_palette_swap_shader(spr_honeypalette,1,false);
	}
	
if (!surface_exists(honeysurf))
	{
		var width=obj_camera.thecamwidth;
		var height=obj_camera.thecamheight;
		honeysurf=surface_create(width,height);
	}
	
surface_set_target(honeysurf);

draw_clear_alpha(0,0);

var hrepeats=(xbound[1]-xbound[0])/sprite_width;
var spr=sprite_index;
var _width=sprite_width;
for (var i=0; i<hrepeats; i+=1)
	{
		//We can keep the V-repeats arbitrary
		for (var j=0; j<6; j+=1)
			{
				if (j>0)
					{
						spr=spr_honeybody;
					}
				else
					{
						spr=sprite_index;
					}
				draw_sprite(spr,image_index,i*_width,j*_width);
			}
	}
	
if (global.rng==1)
	{
		shader_reset();
	}
	
surface_reset_target();

draw_surface_ext(honeysurf,x,y,1,1,0,c_white,0.75);