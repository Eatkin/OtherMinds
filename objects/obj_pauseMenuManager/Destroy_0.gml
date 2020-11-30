/// @description a branch of options

global.hardpause=false;

audio_resume_all();

//Refill hearts if difficulty changes
if (currentDifficulty!=global.difficulty)
	global.Edhealth=scr_return_adjusted_hpmax();

with (obj_music)
	if (nowplaying!=noone)
		audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);

if (loadMap)	{
	if (!instance_exists(obj_map_screen))	{
		scr_set_vibration(0,0,0);
		global.inputs[15]=0; //Make sure we don't hit the pause trigger again in the pause object's step event
		instance_create_layer(x,y,"blocks",obj_map_screen);
	}
}
else if (quitGame)	{
	//Creats a door to the main menu which, by default, saves and quits to menu!
	var door=instance_create_layer(0,0,"blocks",obj_door);
	door.visible=false;
	door.active=true;
	door.destination=rm_main_menu;
	global.softpause=true;
}
else if (returnToHouse)	{
	//Go to the hallway in Ed's House
	var door=instance_create_layer(0,0,"blocks",obj_door);
	door.visible=false;
	door.active=true;
	door.destination=rm_Edhallway;
	global.softpause=true;
}
else if (restartTrial or currentDifficulty!=global.difficulty)	{
	//Restart the room if restarting trial or difficulty change
	var door=instance_create_layer(0,0,"blocks",obj_door);
	door.visible=false;
	door.active=true;
	door.destination=room;
	global.softpause=true;
}