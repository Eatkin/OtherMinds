/// @description

draw_set_colour(c_white);
draw_set_font(global.font);
/*
if (state==UPDATESTATE.CHECKING)
	{
		draw_text(8,8,texttodraw);
	}*/
	
if (state==UPDATESTATE.UPDATEFOUND)
	{
		var highlightcolour=make_colour_rgb(235,211,31);
		draw_set_halign(fa_middle);
		draw_set_valign(fa_center);
		var draw_y=room_height*0.5-options*v_spacing*0.5;
		var draw_x=room_width*0.5;

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
			
		draw_y=room_height*0.1;
		for (var i=0; i<array_length_1d(header); i+=1)
			{
				draw_text(draw_x,draw_y+i*v_spacing,header[i]);
			}
	
		//Draw cursor
		draw_sprite(spr_menucursor,0,cursor_x,cursor_y);
	}