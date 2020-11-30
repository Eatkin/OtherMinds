/// @description QUit to menu when song is finished

if (!audio_is_playing(music))	{
	scr_quit_to_menu();
	instance_destroy();
}
	
alarm[0]=60;