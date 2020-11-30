/// @description draw button and text

var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

//Left
draw_sprite_part(sprite_index,image_index,0,0,16,16,x,y);

//Centre
for (var i=0; i<hrepeats; i+=1)
	draw_sprite_part(sprite_index,image_index,16,0,16,16,x+16*(i+1),y);
	
//End
draw_sprite_part(sprite_index,image_index,32,0,16,16,x+16*(i+1),y);

//Draw text
var hpadding=6;
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(x+hpadding,y+sprite_height*0.5,text);

shader_reset();