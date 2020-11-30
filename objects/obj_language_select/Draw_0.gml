/// @description layy Mlao
// You can write your code in this editor
draw_set_font(global.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);

var draw_y=room_height*0.5-(options-1)*v_spacing*0.5;
var draw_x=room_width*0.5;

var menuSprite=spr_notification_threeline;
spry=(room_height-sprite_get_height(menuSprite))*0.5;
sprx=room_width*0.5-sprite_get_width(menuSprite)*0.5;
draw_sprite(menuSprite,0,sprx,spry);

var highlightcolour=make_colour_rgb(235,211,31);
//Draw text
for (var i=0; i<options; i+=1)
	{
		if (menu_y==i)
			{
				draw_set_colour(highlightcolour);
			}
		draw_text(draw_x,draw_y+i*v_spacing,language[i]);
		if (menu_y==i)
			{
				draw_set_colour(c_white);
			}
	}
	
//Draw cursor
draw_sprite(spr_menucursor,0,cursor_x,cursor_y);