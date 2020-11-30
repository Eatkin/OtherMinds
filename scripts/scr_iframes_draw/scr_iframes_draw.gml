//Created 09/10/19
//Last updated 16/11/19

//Draws self with shaders
//We apply this shader first because it'll get overwritten by the iframes shader!

//This is a bit of a fuckin ugly mess but basically shd_outline has whitesprite built into it now
//If we show the outline shader, we can also turns on whitesprite if conditions are met
//If we don't show the outline shader, it checks to see if it meets the conditions to only draw the whitesprite
if outlineshader=true
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