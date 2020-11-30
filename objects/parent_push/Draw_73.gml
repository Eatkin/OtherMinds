/// @description

if outlineshader=true
	{
		shader_set(shd_outline);
		var w=shader_get_uniform(shd_outline,"pixelwidth");
		var h=shader_get_uniform(shd_outline,"pixelheight");
		var _tex = sprite_get_texture(sprite_index,image_index);
		var tex_width = texture_get_texel_width(_tex);
		var tex_height = texture_get_texel_height(_tex);
		var whitesprite=shader_get_uniform(shd_outline,"whitesprite");
		shader_set_uniform_f(whitesprite,false);
		shader_set_uniform_f(w,tex_width);
		shader_set_uniform_f(h,tex_height);
		draw_self();
		shader_reset();
	}