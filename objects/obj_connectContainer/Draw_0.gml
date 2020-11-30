/// @description

if (textAlpha==0)
	exit;

draw_set_alpha(textAlpha);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
scr_draw_text_outlined(room_width*0.5,room_height*0.52,headerText);
draw_set_alpha(1);