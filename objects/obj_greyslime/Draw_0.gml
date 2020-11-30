/// @description Draws zs

// You can write your code in this editor

scr_iframes_draw();
if waiting=true
	{
		scr_set_palette_swap_shader(spr_gloop_palette,2,false);
		draw_sprite_ext(spr_greenslimezs,-1,x,y,1,1,0,c_white,1);
		shader_reset();
	}
	
//Here we need some custom code for picking a shader
//Normally we set the palette swap shader
//HOWEVER under certain circumstances (outlined and flashing white) we need an alternative
//What did I do to end up with 15 lines of code to draw the player urgh 
if outlineshader=true and iframes%10<5 and iframes>0
	{
		shader_set(shd_outline);
		var w=shader_get_uniform(shd_outline,"pixelwidth");
		var h=shader_get_uniform(shd_outline,"pixelheight");
		var _tex = sprite_get_texture(sprite_index,image_index);
		var tex_width = texture_get_texel_width(_tex);
		var tex_height = texture_get_texel_height(_tex);
		var whitesprite=shader_get_uniform(shd_outline,"whitesprite");
		shader_set_uniform_f(whitesprite,1);
		shader_set_uniform_f(w,tex_width);
		shader_set_uniform_f(h,tex_height);
	}
else if iframes%10<5 and iframes>0
	{
		shader_set(shd_whitesprite);
	}
else
	{
		scr_set_palette_swap_shader(spr_gloop_palette,2,false);
	}

draw_self();
shader_reset();