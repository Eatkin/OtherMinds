/// @description create menus

currentDifficulty=global.difficulty;

activeMenu=PauseMenu.Main;
global.hardpause=true;

//Create menu containers here
menu=0;

menu[0]=instance_create_layer(0,0,layer,obj_mainPauseMenuContainer);
menu[1]=instance_create_layer(0,0,layer,obj_todoListContainer);
menu[2]=instance_create_layer(0,0,layer,obj_bioContainer);
menu[3]=instance_create_layer(0,0,layer,obj_inventoryContainer);
menu[4]=instance_create_layer(0,0,layer,obj_areasContainer);
menu[5]=instance_create_layer(0,0,layer,obj_pauseOptionsContainer);

//A few behaviours
loadMap=false;
quitGame=false;
restartTrial=false;
returnToHouse=false;

//Sound and music
audio_pause_all();

var snd=audio_play_sound(snd_menu_shift,0,false);
audio_sound_gain(snd,global.sound_fx_on*global.sound_fx_volume,0);

with (obj_music)
	if (nowplaying!=noone)	{
		audio_resume_sound(nowplaying);
		audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,500);
	}