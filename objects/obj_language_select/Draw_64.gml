/// @description

//Language credits where applicable

var hudHeight=sprite_get_height(spr_HUD_box);
var GUIheight=display_get_gui_height();
var GUIwidth=display_get_gui_width();
var ydraw=GUIheight-hudHeight*0.5;

if (menu_y==1)
	{
		draw_set_halign(fa_right);
		draw_text(GUIwidth-16,ydraw,"Übersetzung von MikaPyon!");
		draw_set_halign(fa_left);
	}