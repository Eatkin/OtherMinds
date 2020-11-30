/// @description layy Mlao
// You can write your code in this editor
draw_set_font(global.font);
draw_set_halign(fa_top);
draw_set_valign(fa_left);
draw_set_colour(c_white);

var width=room_width;
var height=room_height;

draw_sprite(spr_keyboard,0,width*0.25,height*0.2);
draw_sprite(spr_gamepad,0,width*0.75,height*0.2);

//Now let's use the script I use for binding keys to print out all the keys!
var key;
var input=1; //Keyboard
var v_spacing=18;
var text_y=0.5*(height-v_spacing*numberofcontrols)+sprite_get_height(spr_gamepad);
repeat (2)
	{
		var xdraw=width*0.02+(input-1)*width*0.5;
		for (var i=0; i<numberofcontrols;i+=1)
			{
				#region boring key selection
				switch(i)
					{
						case 0:
							{
								key=global.kb_b_one;
								break;
							}
						case 1:
							{
								key=global.kb_b_two;
								break;
							}
						case 2:
							{
								key=global.kb_b_four;
								break;
							}
						case 3:
							{
								key=global.kb_b_three;
								break;
							}
						case 4:
							{
								key=global.kb_l_one;
								break;
							}
						case 5:
							{
								key=global.kb_r_one;
								break;
							}
						case 6:
							{
								key=global.kb_start;
								break;
							}
						case 7:
							{
								key=global.kb_select;
								break;
							}
					}
				#endregion
				//We'll use this to line everything up
				//(It's the longest string)
				var sprite_x=xdraw+v_spacing+longestoptionlength+8;
				//Now draw the sprite
				var name=options[OPTIONS.CONTROL,i];
				draw_text(xdraw,text_y+i*v_spacing,name);
				if input=1
					{
						var sprite=scr_return_kb_sprite(key)
						if sprite!=-1
							{
								draw_sprite(sprite,0,sprite_x,text_y+i*v_spacing+string_height(name)*0.5);
							}
						else
							{
								//Manually draw
								var buttontext=scr_string_keycheck(key);
								var textwidth=string_width(buttontext);
								var repeats=ceil(textwidth/8);
								draw_sprite(spr_keyboardedge,-1,sprite_x,text_y+i*v_spacing+string_height(name)*0.5);
								var j=0;
								for (j=0;j<repeats;j+=1)
									{
										draw_sprite(spr_keyboardmiddle,-1,sprite_x+8*(j+1),text_y+i*v_spacing+string_height(name)*0.5);
									}
								draw_sprite(spr_keyboardedgeright,-1,sprite_x+8*(j+1),text_y+i*v_spacing+string_height(name)*0.5);
								//The xdraw position is xdraw+ 1/2 the size of the sprites drawn
								draw_set_colour(c_black);
								draw_set_halign(fa_center);
								draw_set_valign(fa_middle);
								draw_text(sprite_x+12+(repeats-1)*4,text_y+i*v_spacing+string_height(name)*0.5,buttontext);
								draw_set_colour(c_white);
								draw_set_halign(fa_left);
								draw_set_valign(fa_top);
							}
					}
				else
					{
						draw_sprite(scr_return_gp_sprite(scr_keyboard_to_gamepad(key)),0,sprite_x,text_y+i*v_spacing+string_height(name)*0.5);
					}
			}
		input+=1;
	}
	
//Press any key text
if pressanykeyalpha=0
	{
		exit;
	}
draw_set_halign(fa_center);
draw_set_alpha(pressanykeyalpha);
draw_text(room_width*0.5,room_height-32,scr_return_text(188));
draw_set_alpha(1);
draw_set_halign(fa_left);