/// @description

if (global.hardpause or global.softpause)
	exit;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
scr_draw_text_outlined(drawxpos,drawypos,text);