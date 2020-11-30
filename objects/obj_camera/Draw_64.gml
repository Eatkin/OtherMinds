/// @description

var guiheight=display_get_gui_height();

if (global.softpause==true and !instance_exists(obj_transition))
	{
		bars_y=lerp(bars_y,guiheight*0.1,0.1);
	}
else
	{
		bars_y=lerp(bars_y,0,0.25);
	}
	
if (bars_y==0)
	{
		exit;
	}
if (abs(bars_y)<1)
	{
		bars_y=0;
	}

draw_set_colour(c_black);
var guiwidth=display_get_gui_width();
draw_rectangle(0,0,guiwidth,bars_y,false);
draw_rectangle(0,guiheight-bars_y,guiwidth,guiheight,false);