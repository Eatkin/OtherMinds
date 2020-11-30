/// @description

if (state!=UPDATESTATE.UPDATEFOUND)
	{
		exit;
	}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var key=global.kb_b_one;

var xdraw=16;
var ydraw=display_get_gui_height()*0.9;
var name="Select";

if global.input=1
	{
		var sprite=scr_return_kb_sprite(key);
		if sprite!=-1
			{
				draw_sprite(sprite,0,xdraw,ydraw);
				xdraw+=sprite_get_width(sprite)+8;
			}
		else
			{
				//Manually draw
				var buttontext=scr_string_keycheck(key);
				var textwidth=string_width(buttontext);
				var repeats=ceil(textwidth/8);
				draw_sprite(spr_keyboardedge,-1,xdraw,ydraw+string_height(name)*0.5);
				var j=0;
				for (j=0;j<repeats;j+=1)
					{
						draw_sprite(spr_keyboardmiddle,-1,xdraw+8*(j+1),ydraw+string_height(name)*0.5);
					}
				draw_sprite(spr_keyboardedgeright,-1,xdraw+8*(j+1),ydraw+string_height(name)*0.5);
				//The xdraw position is xdraw+ 1/2 the size of the sprites drawn
				draw_set_colour(c_black);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_text(xdraw+12+(repeats-1)*4,ydraw+string_height(name)*0.5,buttontext);
				draw_set_colour(c_white);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
						
				xdraw+=8*(repeats+3);
			}
	}
else
	{
		var sprite=scr_return_gp_sprite(scr_keyboard_to_gamepad(key))
		draw_sprite(sprite,0,xdraw,ydraw+string_height(name)*0.5);
		xdraw+=sprite_get_width(sprite)+8;
	}
		
draw_text(xdraw,ydraw,name);