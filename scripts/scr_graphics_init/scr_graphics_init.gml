//Created: 23/05/19
//Last updated: 23/05/19

//This is the graphics initialisation when the game first starts
//First we'll set the window size to what it should be
//IMPORTANT NOTE - THE FIRST ROOM SIZE ACTUALLY ALTERS THE SCALE SO MAKE SURE IT'S CORRECT!
//I've added in failsafes
var width=480;
var height=270;
room_width=width;
room_height=height;
//This is error trapping to stop the window being bigger than the display which will cause catastrophic crashes
//(I've tried, it generates crashes outside of Gamemaker lol)
//Anyway the config file might have a window scale larger than the screen supports for various reasons
while (global.windowscale*width>display_get_width() or global.windowscale*height>display_get_height())
	{
		global.windowscale-=1;
	}
if (window_get_fullscreen()==false)
	{
		window_set_size(width*global.windowscale,height*global.windowscale);
		alarm[0]=1;
	}
display_set_gui_size(width,height);


//Disable application surface drawing
application_surface_draw_enable(0);

//Call the particle setup script
global.partSys=noone;
scr_particles();