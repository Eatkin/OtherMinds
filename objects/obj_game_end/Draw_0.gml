/// @description layy Mlao
// You can write your code in this editor
draw_set_font(global.font);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
draw_set_colour(c_white);

var draw_y=room_height*0.6-options*v_spacing*0.5;
var draw_x=room_width*0.5;

draw_sprite(sprite_index,image_index,draw_x,draw_y-v_spacing*1.5);

var highlightcolour=make_colour_rgb(235,211,31);

//Draw text
for (var i=0; i<options; i+=1)
	{
		if (menu_y==i)
			{
				draw_set_colour(highlightcolour);
			}
		draw_text(draw_x,draw_y+i*v_spacing,option[i]);
		if (menu_y==i)
			{
				draw_set_colour(c_white);
			}
	}
	
//Draw cursor
draw_sprite(spr_menucursor,0,cursor_x,cursor_y);

//Now draw the headers
draw_y=v_spacing*1.5;
for (var i=0; i<array_length_1d(header); i+=1)
	{
		draw_text(draw_x,draw_y+i*v_spacing,header[i]);
	}