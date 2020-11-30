/// @description

if !surface_exists(diarysurface)
	{
		diarysurface=surface_create(menuwidth,menuheight);
	}
	
//Set up font variables
draw_set_colour(c_white);
draw_set_font(global.font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

surface_set_target(diarysurface);

draw_clear_alpha(0,0);
//Starting position for drawing
//We'll draw from button upwards
var v_spacing=16;
var drawx=16;
var drawy=menuheight-32;

var textheight=string_height("A");
for (var i=0; i<counter; i+=1)	
	{
		if (menu_y_selection==i)
			{
				shader_set(shd_outline);
				#region uniforms
				var w=shader_get_uniform(shd_outline,"pixelwidth");
				var h=shader_get_uniform(shd_outline,"pixelheight");
				var _tex = sprite_get_texture(spr_elevator_button,0);
				var tex_width = texture_get_texel_width(_tex);
				var tex_height = texture_get_texel_height(_tex);
				var whitesprite=shader_get_uniform(shd_outline,"whitesprite");
				shader_set_uniform_f(whitesprite,false);
				shader_set_uniform_f(w,tex_width);
				shader_set_uniform_f(h,tex_height);
				#endregion
			}
		draw_sprite(spr_elevator_button,0,drawx,drawy-i*v_spacing);
		
		if (menu_y_selection==i)
			{
				shader_reset();
			}
		draw_text(drawx+16,drawy-i*v_spacing+(v_spacing-textheight)*0.5,i);
	}
	
surface_reset_target();

draw_sprite(spr_elevator_pad,0,menu_x,menu_y);

draw_surface(diarysurface,menu_x,menu_y);