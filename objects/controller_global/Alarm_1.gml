/// @description go to the first room

//This script sets the frame rate
//it actually just sets room_speed to 60fps which is the default anyway so who cares lolololol
scr_roomstart_setup_all();

//Go to menu
if (room==room_setup)
	{
		/*Uncomment for credits warp
		room_goto(room_credits);
		exit;*/
		room_goto(rm_splash);
	}