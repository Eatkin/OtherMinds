/// @description Draw!!!!!!1111!one!!

if (global.rng==1)
	{
		scr_set_palette_swap_shader(spr_hb_palette,1,false);
	}
else if outlineshader=true
	{
		shader_set(shd_outline);
		var w=shader_get_uniform(shd_outline,"pixelwidth");
		var h=shader_get_uniform(shd_outline,"pixelheight");
		var _tex = sprite_get_texture(sprite_index,image_index);
		var tex_width = texture_get_texel_width(_tex);
		var tex_height = texture_get_texel_height(_tex);
		var whitesprite=shader_get_uniform(shd_outline,"whitesprite");
		shader_set_uniform_f(whitesprite,(iframes%10<5 and iframes>0));
		shader_set_uniform_f(w,tex_width);
		shader_set_uniform_f(h,tex_height);
		draw_self();
		shader_reset();
	}
if iframes>0
	{
		if iframes%10<5
			{
				//my blacktowhite shader doesn't work for some reason but this is fine
				shader_set(shd_whitesprite);
				draw_self();
				shader_reset();
			}
		else
			{
				draw_self();
			}
	}
else
	{
		draw_self();
	}

if (global.rng==1)
	{
		var _spr=spr_bandanna;
		if (state==PlayerState.defeated)
			{
				_spr=spr_bandanna_defeated;
			}
		draw_sprite_ext(_spr,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
		shader_reset();
	}